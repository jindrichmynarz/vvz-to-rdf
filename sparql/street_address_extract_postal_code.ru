PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:streetAddress ?_streetAddress .
}
INSERT {
  ?address schema:streetAddress ?streetAddress ;
    schema:postalCode ?postalCode .
}
WHERE {
  ?address a schema:PostalAddress ;
    schema:streetAddress ?_streetAddress .
  FILTER REGEX(?_streetAddress, "\\s\\d{3}\\s?\\d{2}\\s")
  BIND (REPLACE(?_streetAddress, "\\s\\d{3}\\s?\\d{2}", "") AS ?streetAddress)
  BIND (REPLACE(?_streetAddress, "^.*\\s(\\d{3})\\s?(\\d{2})\\s.*$", "$1$2") AS ?postalCode)
}
