PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?contract pc:actualPrice ?o2 .
  ?o2 ?p ?o .
}
WHERE {
  ?contract pc:actualPrice ?o1, ?o2 .
  FILTER (!sameTerm(?o1, ?o2) && isBlank(?o1) && isBlank(?o2))
  FILTER NOT EXISTS {
    ?o1 ?p ?o .
    FILTER NOT EXISTS {
      ?o2 ?p ?o .
    }
  }
  ?o2 ?p ?o .
}
