PREFIX schema: <http://schema.org/>

INSERT {
  ?address schema:postalCode ?postalCode .
}
WHERE {
  ?address a schema:PostalAddress .
  FILTER NOT EXISTS {
    ?address schema:postalCode [] .
  }
  ?address schema:streetAddress ?streetAddress .
  FILTER REGEX(?streetAddress, "^.*\\d{3}\\s?\\d{2}.*$")
  BIND (REPLACE(?streetAddress, "(\\d{3})\\s?(\\d{2})", "$1$2") AS ?postalCode)
}
