PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress .
}
WHERE {
  ?address schema:streetAddress ?_streetAddress .
  FILTER STRSTARTS(LCASE(?_streetAddress), "ul.")
  BIND (REPLACE(?_streetAddress, "^[uU]l\\.\\s*", "") AS ?streetAddress)
}
