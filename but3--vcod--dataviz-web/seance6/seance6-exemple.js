d3.csv(
    "https://fxjollois.github.io/donnees/scimagojr/scimagojr.csv",
    function (d) {
        return {
            Country: d.Country,
            Region: d.Region,
            Year: parseInt(d.Year),
            Rank: parseInt(d.Rank),
            Documents: parseInt(d.Documents),
            Citations: parseInt(d.Citations),
            Hindex: parseInt(d["H index"])
        };
    })
    .then(function(data) {
        // Création du tableau
        d3.select("#contenant").append("table")
            .attr("id", "table_donnees")
            .attr("class", " compact hover order-column stripe")
            .append("thead")
            .append("tr")
            .selectAll("th")
            .data(Object.keys(data[0]))
            .enter()
            .append("th")
            .html(d => d);
        d3.select("#table_donnees").append("tbody")
            .selectAll("tr")
            .data(data)
            .enter()
            .append("tr").selectAll("td")
                .data(d => Object.values(d))
                .enter()
                .append("td")
                .html(d => d);
    
        new DataTable("#table_donnees", { caption : "Production scientifique mondiale depuis 1996" });
});

