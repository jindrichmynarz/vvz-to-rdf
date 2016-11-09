PREFIX isvz: <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX pc:   <http://purl.org/procurement/public-contracts#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?awardCriterion skos:prefLabel ?_label .
}
INSERT {
  ?awardCriterion skos:prefLabel ?label .
}
WHERE {
  [] pc:weightedCriterion|isvz:mainCriterion ?awardCriterion .
  ?awardCriterion skos:prefLabel ?_label .
  BIND (SUBSTR(?_label, 1, 1) AS ?firstLetter)
  FILTER (?firstLetter != UCASE(?firstLetter))
  BIND (CONCAT(UCASE(?firstLetter), SUBSTR(?_label, 2)) AS ?label)
}
