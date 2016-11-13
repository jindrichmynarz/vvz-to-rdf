PREFIX schema: <http://schema.org/>

DELETE {
  ?place ?p ?o .
}
WHERE {
  ?place a schema:Place .
  FILTER NOT EXISTS {
    [] ?inP ?place .
  }
  ?place ?p ?o .
}
