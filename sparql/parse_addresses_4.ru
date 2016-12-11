PREFIX ruian:  <http://ruian.linked.opendata.cz/ontology/>
PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress ;
    ruian:cisloDomovni ?houseNumber .
}
WHERE {
  ?address schema:addressCountry "CZ" ;
    schema:streetAddress ?_streetAddress .

  FILTER REGEX(?_streetAddress, "\\s+\\d+$")
  BIND (REPLACE(?_streetAddress, "(\\s+\\d+)$", "") AS ?streetAddress)
  BIND (REPLACE(?_streetAddress, "^.*\\s+(\\d+)$", "$1") AS ?houseNumber)
}
