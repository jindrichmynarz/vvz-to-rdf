PREFIX schema: <http://schema.org/>

DELETE {
  ?address schema:postalCode ?_postalCode .
}
WHERE {
  ?address schema:addressCountry "CZ" ;
    schema:postalCode ?_postalCode .
  FILTER (!REGEX(?_postalCode, "^\\d{5}$"))
}
