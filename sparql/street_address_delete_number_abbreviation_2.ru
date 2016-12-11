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
  FILTER REGEX(?_streetAddress, "č\\.\\s")
  BIND (REPLACE(?_streetAddress, "č\\.\\s", "") AS ?streetAddress)
}
