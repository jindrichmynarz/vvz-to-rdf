PREFIX ruian:  <http://ruian.linked.opendata.cz/ontology/>
PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress ;
    ruian:cisloDomovni ?cp ;
    ruian:cisloOrientacni ?co ;
    ruian:cisloOrientacniPismeno ?cop .
}
WHERE {
  ?address schema:addressCountry "CZ" ;
    schema:streetAddress ?_streetAddress .
  
  # Switched order between číslo orientační and číslo popisné
  FILTER REGEX(?_streetAddress, "^.*\\s+\\d+[a-zA-Z]\\/\\d+$")
  BIND (REPLACE(?_streetAddress, "^(.*)\\s+\\d+[a-zA-Z]\\/\\d+$", "$1") AS ?streetAddress)
  BIND (REPLACE(?_streetAddress, "^.*\\s+(\\d+)[a-zA-Z]\\/\\d+$", "$1") AS ?co)
  BIND (REPLACE(?_streetAddress, "^.*\\s+\\d+([a-zA-Z])\\/\\d+$", "$1") AS ?cop)
  BIND (REPLACE(?_streetAddress, "^.*\\s+\\d+[a-zA-Z]\\/(\\d+)$", "$1") AS ?cp)
}
