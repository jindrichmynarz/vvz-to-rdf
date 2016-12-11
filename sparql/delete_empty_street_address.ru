PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?streetAddress .
}
WHERE {
  ?address schema:streetAddress ?streetAddress .
  FILTER (?streetAddress = "" || REGEX(?streetAddress, "^[,\\-\\.]$"))
}
