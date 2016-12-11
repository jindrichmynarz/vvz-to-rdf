PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:postalCode "" .
}
WHERE {
  ?address schema:postalCode "" .
}
