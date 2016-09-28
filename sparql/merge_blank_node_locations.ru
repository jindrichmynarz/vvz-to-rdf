PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?contract pc:location ?location2 .
  ?location2 ?p ?o .
}
WHERE {
  ?contract a pc:Contract ;
    pc:location ?location1, ?location2 .
  FILTER (!sameTerm(?location1, ?location2) && isBlank(?location1) && isBlank(?location2))
  FILTER NOT EXISTS {
    ?location1 ?p ?o .
    FILTER NOT EXISTS {
      ?location2 ?p ?o .
    }
  }
  ?location2 ?p ?o .
}
