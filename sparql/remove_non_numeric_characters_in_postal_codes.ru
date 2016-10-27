PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:postalCode ?_postalCode .
}
INSERT {
  ?address schema:postalCode ?postalCode .
}
WHERE {
  ?address schema:addressCountry "CZ" ;
    schema:postalCode ?_postalCode .
  FILTER REGEX(?_postalCode, "^\\d{3}[^\\d]\\d{2}$")
  BIND (REPLACE(?_postalCode, "^(\\d{3})[^\\d](\\d{2})$", "$1$2") AS ?postalCode)
}
