PREFIX ruian:  <http://ruian.linked.opendata.cz/ontology/>

DELETE {
  ?address ruian:cisloOrientacniPismeno ?_orientationalNumberLetter .
}
INSERT {
  ?address ruian:cisloOrientacniPismeno ?orientationalNumberLetter .
}
WHERE {
  ?address ruian:cisloOrientacniPismeno ?_orientationalNumberLetter .
  FILTER (?_orientationalNumberLetter = UCASE(?_orientationalNumberLetter))
  BIND (LCASE(?_orientationalNumberLetter) AS ?orientationalNumberLetter)
}
