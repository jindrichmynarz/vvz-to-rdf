PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress .
}
WHERE {
  ?address schema:streetAddress ?_streetAddress .
  FILTER CONTAINS(?_streetAddress, " ul. ")
  BIND (REPLACE(?_streetAddress, " ul. ", " ") AS ?streetAddress)
}
