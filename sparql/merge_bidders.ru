PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?s pc:bidder ?bidder1 .
  ?bidder1 ?outP ?outO .
  ?inS ?inP ?bidder1 .
}
INSERT {
  ?inS ?inP ?bidder2 .
}
WHERE {
  ?s pc:bidder ?bidder1, ?bidder2 .
  FILTER (!sameTerm(?bidder1, ?bidder2))
  FILTER NOT EXISTS {
    ?bidder1 ?p ?o .
    FILTER NOT EXISTS {
      ?bidder2 ?p ?o .
    }
  }
  ?bidder1 ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?bidder1 .
  }
}
