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
  FILTER CONTAINS(?_streetAddress, ";")

  VALUES ?n { 1 2 3 4 5 6 7 8 9 10 } # Split at most 10 street addresses

  BIND (CONCAT("^([^;]*;){", STR(?n) ,"} *") AS ?skipN)
  BIND (REPLACE(REPLACE(?_streetAddress, ?skipN, ""), ";.*$", "") AS ?streetAddress)
}
