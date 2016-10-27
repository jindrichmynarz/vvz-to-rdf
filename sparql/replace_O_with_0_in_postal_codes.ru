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
  FILTER CONTAINS(?_postalCode, "O")
  BIND (REPLACE(?_postalCode, "O", "0") AS ?postalCode)
}
