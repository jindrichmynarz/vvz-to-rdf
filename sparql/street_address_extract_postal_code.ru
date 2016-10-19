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
  FILTER REGEX(?streetAddress, "^.*\\s\\d{3}\\s?\\d{2}\\s.*$")
  BIND (REPLACE(?streetAddress, "\\s(\\d{3})\\s?(\\d{2})\\s", "$1$2") AS ?postalCode)
}
