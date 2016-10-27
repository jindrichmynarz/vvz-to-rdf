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
  FILTER REGEX(?_postalCode, "^\\d+$")
  BIND (STRLEN(?_postalCode) AS ?strlen)
  FILTER (?strlen < 5)
  VALUES (?strlen ?padding) {
    (1 "0000")
    (2 "000")
    (3 "00")
    (4 "0")
  }
  BIND (CONCAT(?_postalCode, ?padding) AS ?postalCode)
}
