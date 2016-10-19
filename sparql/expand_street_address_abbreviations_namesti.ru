PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress .
}
WHERE {
  ?address schema:streetAddress ?_streetAddress .
  FILTER CONTAINS(?_streetAddress, "nám. ")
  BIND (REPLACE(?_streetAddress, "nám\\. ", "náměstí ") AS ?streetAddress)
}
