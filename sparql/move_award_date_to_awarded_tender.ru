PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?contract pc:awardDate ?awardDate .
}
INSERT {
  ?tender pc:awardDate ?awardDate .
}
WHERE {
  ?contract pc:awardDate ?awardDate ;
    pc:awardedTender ?tender .
}
