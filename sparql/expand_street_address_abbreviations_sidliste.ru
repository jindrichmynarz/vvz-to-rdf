PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress .
}
WHERE {
  ?address schema:streetAddress ?_streetAddress .
  FILTER CONTAINS(LCASE(?_streetAddress), "sídl. ")
  BIND (REPLACE(?_streetAddress, "(s|S)ídl\\. ", "$1ídliště ") AS ?streetAddress)
}
