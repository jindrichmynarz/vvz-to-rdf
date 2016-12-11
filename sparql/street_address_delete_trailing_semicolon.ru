PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress .
}
WHERE {
  ?address schema:streetAddress ?_streetAddress .
  FILTER (STRLEN(?_streetAddress) > 1 && STRENDS(?_streetAddress, ";"))
  BIND (SUBSTR(?_streetAddress, 1, STRLEN(?_streetAddress) - 1) AS ?streetAddress)
}
