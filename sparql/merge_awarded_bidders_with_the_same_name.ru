PREFIX pc:     <http://purl.org/procurement/public-contracts#>
PREFIX rov:    <http://www.w3.org/ns/regorg#>
PREFIX schema: <http://schema.org/>
PREFIX skos:   <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?contract pc:awardedTender ?tender .
  ?tender ?tenderP ?tenderO .
  ?bidder ?bidderP ?bidderO .
}
INSERT {
  ?sampleBidder ?bidderP ?bidderO .
}
WHERE {
  {
    SELECT ?contract ?bidderName (SAMPLE(?bidder) AS ?sampleBidder)
    WHERE {
      ?contract pc:awardedTender/pc:bidder ?bidder .
      ?bidder schema:legalName ?bidderName .
    }
    GROUP BY ?contract ?bidderName
    HAVING (COUNT(?bidder) > 1)
  }
  ?contract pc:awardedTender ?tender .
  ?tender pc:bidder ?bidder .
  ?bidder schema:legalName ?bidderName .
  FILTER (!sameTerm(?bidder, ?sampleBidder))
  ?tender ?tenderP ?tenderO .
  ?bidder ?bidderP ?bidderO .
}
