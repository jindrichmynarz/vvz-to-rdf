PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:addressLocality ?addressLocality .
}
WHERE {
  ?address schema:addressLocality ?addressLocality .
  FILTER REGEX(?addressLocality, "^\\.+$")
}
