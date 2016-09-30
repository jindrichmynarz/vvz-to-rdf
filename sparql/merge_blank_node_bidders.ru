PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?s pc:bidder ?bidder1 .
  ?bidder1 ?p ?o .
}
WHERE {
  ?s pc:bidder ?bidder1, ?bidder2 .
  FILTER (!sameTerm(?bidder1, ?bidder2) && isBlank(?bidder1) && isBlank(?bidder2))
  FILTER NOT EXISTS {
    ?bidder1 ?p ?o .
    FILTER NOT EXISTS {
      ?bidder2 ?p ?o .
    }
  }
  ?bidder1 ?p ?o .
}
