PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?contract pc:location ?location1 .
  ?location1 ?outP ?outO .
  ?inS ?inP ?location1 .
}
INSERT {
  ?inS ?inP ?location2 .
}
WHERE {
  ?contract a pc:Contract ;
    pc:location ?location1, ?location2 .
  FILTER (!sameTerm(?location1, ?location2))
  FILTER NOT EXISTS {
    ?location1 ?p ?o .
    FILTER NOT EXISTS {
      ?location2 ?p ?o .
    }
  }
  ?location1 ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?location1 .
  }
}
