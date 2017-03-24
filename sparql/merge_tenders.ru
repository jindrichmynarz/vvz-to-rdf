PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
	?contract pc:awardedTender ?tender .
  ?tender ?tenderP ?tenderO .
}
INSERT {
  ?sampleTender ?tenderP ?tenderO .
}
WHERE {
	{
		SELECT ?contract ?bidder (SAMPLE(?tender) AS ?sampleTender)
		WHERE {
			?contract pc:awardedTender ?tender .
			?tender pc:bidder ?bidder .
		}
		GROUP BY ?contract ?bidder
		HAVING (COUNT(DISTINCT ?tender) > 1)
	}
	?contract pc:awardedTender ?tender .
	?tender pc:bidder ?bidder .
  FILTER (!sameTerm(?tender, ?sampleTender))
  ?tender ?tenderP ?tenderO .
}
