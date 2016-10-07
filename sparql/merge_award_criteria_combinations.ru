PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?o1 ?outP ?outO .
  ?inS ?inP ?o1 .
}
INSERT {
  ?inS ?inP ?o2 .
}
WHERE {
  ?o1 a pc:AwardCriteriaCombination .
  ?o2 a pc:AwardCriteriaCombination .
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
