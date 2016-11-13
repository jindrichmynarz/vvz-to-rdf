PREFIX foaf: <http://xmlns.com/foaf/0.1/>

DELETE {
  ?project ?p ?o .
}
WHERE {
  ?project a foaf:Project .
  FILTER NOT EXISTS {
    [] ?inP ?project .
  }
  ?project ?p ?o .
}
