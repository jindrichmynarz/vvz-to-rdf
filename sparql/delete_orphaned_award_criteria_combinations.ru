PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?awardCriteriaCombination ?p ?o .
}
WHERE {
  ?awardCriteriaCombination a pc:AwardCriteriaCombination .
  FILTER NOT EXISTS {
    [] ?inP ?awardCriteriaCombination .
  }
  ?awardCriteriaCombination ?p ?o .
}
