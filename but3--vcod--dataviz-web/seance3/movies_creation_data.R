library(jsonlite)
library(tidyverse)

movies = fromJSON("movies.json") %>% 
  filter(title != "Yi Yi") %>%
  filter(title != "A Midsummer Night's Dream") %>%
  filter(title != "The Civil War") %>%
  filter(title != "The Shawshank Redemption")
table(sapply(movies$genres, length))

names(movies)

###########################################################
# Nb films par genre
###########################################################

top_genres = data.frame(unlist(movies$genres) %>% table())
names(top_genres) = c("Genre", "NbFilms")
top_genres

write(paste0("var top_genres = ", toJSON(top_genres %>% arrange(NbFilms), pretty = T), ";"), 
      file = "top_genres.js")

ggplot(data = top_genres, aes(reorder(Genre, NbFilms), NbFilms)) +
  geom_bar(stat = "identity") + coord_flip() +
  theme_minimal() +
  labs(x = "", y = "")

###########################################################
# Evolution genre par année
###########################################################
evol_genres = Reduce(
  function(a, b) {
    return (rbind(a, b))
  },
  lapply(1:nrow(movies), function (i) {
    m = movies[i,]
    g = m$genres
    #print(g)
    #cat(ifelse(is.null(g[[1]]), "vide", i), " - ", unlist(g), " | ", m$year, "\n")
    m = data.frame(ifelse(is.null(g[[1]]), "Aucune", g), substr(m$year, 1, 4))
    names(m) = c("Genre", "Annee")
    return (m)
})
)
evol_genres_bis = evol_genres %>% group_by(Annee, Genre) %>% summarise(Nb = n()) %>% mutate(Annee = as.integer(Annee))

write(paste0("var evol_genres = ", toJSON(evol_genres_bis, pretty = T), ";"), 
      file = "evol_genres.js")

ggplot(evol_genres_bis, 
       aes(Annee, Nb, color = Genre, group = Genre)) +
  geom_line() +
  theme_minimal() +
  labs(x = "", y = "")

###########################################################
# Notes des films
###########################################################
notes_films = Reduce(
  function(a, b) {
    return (rbind(a, b))
  },
  lapply(1:nrow(movies), function (i) {
    m = movies[i,]
    g = m$genres[[1]]
    return (data.frame(
      Titre = m$title,
      Annee = substr(m$year, 1, 4),
      Rotten = m$tomatoes$viewer$rating,
      IMDB = as.numeric(m$imdb$rating),
      Genre1 = ifelse(is.null(g), NA, g[1]),
      Genre2 = ifelse(is.null(g), NA, g[2]),
      Genre3 = ifelse(is.null(g), NA, g[3]),
      Genres = ifelse(is.null(g), NA, g)
      ))
    })
)

notes_films %>% arrange(desc(Rotten)) %>% head(50)
notes_films %>% arrange(desc(IMDB)) %>% head(50)

write(paste0("var top_films_Rotten = ", 
             toJSON(notes_films %>% arrange(desc(Rotten)) %>% select(-Genre1, -Genre2, -Genre3, -IMDB), pretty = T), ";"), 
      file = "top_films_Rotten.js")
write(paste0("var top_films_IMDB = ", 
             toJSON(notes_films %>% arrange(desc(IMDB)) %>% select(-Genre1, -Genre2, -Genre3, -Rotten), pretty = T), ";"), 
      file = "top_films_IMDB.js")

ggplot(notes_films %>% arrange(desc(Rotten)) %>% head(20), aes(Titre, Rotten)) +
  geom_bar(stat = "identity") + coord_flip() +
  theme_minimal()

ggplot(notes_films %>% arrange(desc(IMDB)) %>% head(20), aes(reorder(Titre, IMDB), IMDB)) +
  geom_bar(stat = "identity") + coord_flip() +
  theme_minimal()
  
save(top_genres, evol_genres_bis, notes_films, file = "movies.RData")

