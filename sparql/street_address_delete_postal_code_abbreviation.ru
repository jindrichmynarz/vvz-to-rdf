PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress .
}
WHERE {
  ?address schema:addressCountry "CZ" ;
    schema:streetAddress ?_streetAddress .
  FILTER REGEX(?_streetAddress, "PSČ")
  BIND (REPLACE(?_streetAddress, "PSČ\\s*", "") AS ?streetAddress)
}
