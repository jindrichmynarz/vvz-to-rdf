PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?concept ?p ?o .
}
WHERE {
  ?concept a skos:Concept .
  FILTER NOT EXISTS {
    [] ?inP ?concept .
  }
  ?concept ?p ?o .
}
