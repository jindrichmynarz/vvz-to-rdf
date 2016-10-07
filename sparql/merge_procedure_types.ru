PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?contract pc:procedureType ?o1 .
  ?o1 ?outP ?outO .
  ?inS ?inP ?o1 .
}
INSERT {
  ?inS ?inP ?o2 .
}
WHERE {
  ?contract a pc:Contract ;
    pc:procedureType ?o1, ?o2 .
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
