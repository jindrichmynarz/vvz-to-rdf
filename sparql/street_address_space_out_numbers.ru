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
  FILTER REGEX(?_streetAddress, "\\p{L}\\d")
  BIND (REPLACE(?_streetAddress, "(\\p{L})(\\d)", "$1 $2") AS ?streetAddress)
}
