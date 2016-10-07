PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?o1 ?outP ?outO .
  ?inS ?inP ?o1 .
}
INSERT {
  ?inS ?inP ?o2 .
}
WHERE {
  ?o1 a skos:Concept .
  ?o2 a skos:Concept .
  FILTER (!sameTerm(?o1, ?o2))
  FILTER NOT EXISTS {
    ?o1 ?p ?o .
    FILTER NOT EXISTS {
      ?o2 ?p ?o .
    }
  }
  ?o1 ?inP ?inO .
  OPTIONAL {
    ?inS ?inP ?o1 .
  }
}
