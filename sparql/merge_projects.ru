PREFIX foaf: <http://xmlns.com/foaf/0.1/>

DELETE {
  ?o1 ?outP ?outO .
  ?inS ?inP ?o1 .
}
INSERT {
  ?inS ?inP ?o2 .
}
WHERE {
  ?o1 a foaf:Project .
  ?o2 a foaf:Project .
  FILTER (!sameTerm(?o1, ?o2))
  FILTER NOT EXISTS {
    ?o1 ?p ?o .
    FILTER NOT EXISTS {
      ?o2 ?p ?o .
    }
  }
  ?o1 ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?o1 .
  }
}
