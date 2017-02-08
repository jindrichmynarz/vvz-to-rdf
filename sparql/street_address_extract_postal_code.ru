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
  FILTER NOT EXISTS {
    ?address schema:postalCode [] .
  }
  FILTER REGEX(?_streetAddress, "\\d{3}\\s?\\d{2}")
  BIND (REPLACE(?_streetAddress, "\\s*\\d{3}\\s?\\d{2}", "") AS ?streetAddress)
  BIND (REPLACE(?_streetAddress, "^.*(\\d{3})\\s?(\\d{2}).*$", "$1$2") AS ?postalCode)
}
