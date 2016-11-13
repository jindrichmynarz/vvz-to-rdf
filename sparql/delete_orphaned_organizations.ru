PREFIX schema: <http://schema.org/>

DELETE {
  ?organization ?p ?o .
}
WHERE {
  ?organization a schema:Organization .
  FILTER NOT EXISTS {
    [] ?inP ?organization .
  }
  ?organization ?p ?o .
}
