PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress .
}
WHERE {
  ?address schema:streetAddress ?_streetAddress .
  BIND ("Dubna|Května|Máje|Října|Listopadu|Pluku" AS ?words)
  FILTER REGEX(?_streetAddress, CONCAT("^.*", ?words, ".*$"))
  BIND (REPLACE(?_streetAddress, CONCAT("^.*(", ?words, ").*$"), "$1") AS ?word)
  BIND (REPLACE(?_streetAddress, ?word, LCASE(?word)) AS ?streetAddress)
}
