PREFIX ruian:  <http://ruian.linked.opendata.cz/ontology/>
PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address ruian:cisloDomovni ?cp ;
    ruian:cisloOrientacni ?co ;
    ruian:cisloOrientacniPismeno ?cop .
}
WHERE {
  ?address schema:addressCountry "CZ" ;
    schema:streetAddress ?streetAddress .

  FILTER REGEX(?streetAddress, "^\\d+\\/?\\d*[a-zA-Z]?$")
  BIND (REPLACE(?streetAddress, "^(\\d+)\\/?\\d*[a-zA-Z]?$", "$1") AS ?cp)
  BIND (REPLACE(?streetAddress, "^\\d+\\/?(\\d+)[a-zA-Z]?$", "$1") AS ?co)
  BIND (REPLACE(?streetAddress, "^\\d+\\/?\\d*([a-zA-Z])?$", "$1") AS ?cop)
}
