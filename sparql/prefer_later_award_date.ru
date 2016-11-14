PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?tender pc:awardDate ?earlierDate .
}
WHERE {
  ?tender pc:awardDate ?earlierDate, ?laterDate .
  FILTER (?earlierDate < ?laterDate)
}
