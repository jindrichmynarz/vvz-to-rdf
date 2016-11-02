PREFIX isvz: <http://linked.opendata.cz/ontology/isvz.cz/>

DELETE {
  ?contract ?p1 ?o1 .
  ?o1 ?p2 ?o2 .
  ?o2 ?p3 ?o3 .
}
WHERE {
  ?contract isvz:isValid false ;
    ?p1 ?o1 .
  OPTIONAL {
    ?o1 ?p2 ?o2 .
    FILTER isBlank(?o1)
    OPTIONAL {
      ?o2 ?p3 ?o3 .
      FILTER isBlank(?o2)
    }
  }
}
