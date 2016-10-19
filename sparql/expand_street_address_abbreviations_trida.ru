PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress .
}
WHERE {
  ?address schema:streetAddress ?_streetAddress .
  FILTER CONTAINS(?_streetAddress, "tř. ")
  BIND (REPLACE(?_streetAddress, "tř\\. ", "třída ") AS ?streetAddress)
}
