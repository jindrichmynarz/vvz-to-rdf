PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?contract ?p1 ?o1 .
  ?o1 ?p2 ?o2 .
  ?o2 ?p3 ?o3 .
}
WHERE {
  ?contract pc:isValid false ;
    ?p1 ?o1 .
  OPTIONAL {
    FILTER isBlank(?o1)
    ?o1 ?p2 ?o2 .
    OPTIONAL {
      FILTER isBlank(?o2)
      ?o2 ?p3 ?o3 .
    }
  }
}
