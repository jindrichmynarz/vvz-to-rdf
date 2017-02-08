PREFIX schema: <http://schema.org/>

INSERT {
  ?address schema:postalCode ?postalCode .
}
WHERE {
  ?address a schema:PostalAddress ;
    schema:description ?description .
  FILTER NOT EXISTS {
    ?address schema:postalCode [] .
  }
  FILTER REGEX(?description, "\\d{3}\\s?\\d{2}")
  BIND (REPLACE(?description, "^.*(\\d{3})\\s?(\\d{2}).*$", "$1$2") AS ?postalCode)
}
