PREFIX pc:  <http://purl.org/procurement/public-contracts#>

WITH <http://linked.opendata.cz/resource/dataset/isvz.cz>
DELETE {
  ?s pc:awardDate ?awardDate .
}
WHERE {
  ?s pc:awardDate ?awardDate .
  FILTER (?awardDate > now())
}
