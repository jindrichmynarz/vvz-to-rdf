PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?criterionWeighting ?p ?o .
}
WHERE {
  ?criterionWeighting a pc:CriterionWeighting .
  FILTER NOT EXISTS {
    [] ?inP ?criterionWeighting .
  }
  ?criterionWeighting ?p ?o .
}
