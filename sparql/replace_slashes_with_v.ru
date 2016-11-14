PREFIX dcterms: <http://purl.org/dc/terms/>

DELETE {
  ?s dcterms:description ?_literal .
}
INSERT {
  ?s dcterms:description ?literal .
}
WHERE {
  ?s dcterms:description ?_literal .
  FILTER (isLiteral(?_literal) && contains(str(?_literal), "\\/"))
  BIND (REPLACE(str(?_literal), "\\/", "V") AS ?literal)
}
