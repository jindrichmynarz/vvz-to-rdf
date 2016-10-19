PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress .
}
WHERE {
  ?address schema:streetAddress ?_streetAddress .
  FILTER CONTAINS(LCASE(?_streetAddress), "bří. ")
  BIND (REPLACE(?_streetAddress, "(b|B)ří\\. ", "$1ratří ") AS ?streetAddress)
}
