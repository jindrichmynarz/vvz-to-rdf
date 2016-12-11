PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress .
}
WHERE {
  ?address schema:streetAddress ?_streetAddress .
  FILTER (REGEX(?_streetAddress, "^\\s+") || REGEX(?_streetAddress, "\\s+$"))
  BIND (REPLACE(?_streetAddress, "^\\s*(.+)\\s*$", "$1") AS ?streetAddress)
}
