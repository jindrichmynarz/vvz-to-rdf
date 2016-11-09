PREFIX isvz:    <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX pc:      <http://purl.org/procurement/public-contracts#>

DELETE {
  ?notice pc:contractingAuthority ?contractingAuthority .
  ?contractingAuthority ?outP ?outO .
}
INSERT {
  ?notice pc:contractingAuthority ?sampleContractingAuthority .
  ?sampleContractingAuthority ?outP ?outO .
}
WHERE {
  {
    SELECT ?contract
           (SAMPLE(?_contractingAuthority) AS ?sampleContractingAuthority)
    WHERE {
      ?contract isvz:notice/pc:contractingAuthority ?_contractingAuthority . 
    }
    GROUP BY ?contract
    HAVING (COUNT(DISTINCT ?_contractingAuthority) > 1)
  }
  ?contract isvz:notice ?notice .
  ?notice pc:contractingAuthority ?contractingAuthority .
  FILTER (!sameTerm(?contractingAuthority, ?sampleContractingAuthority))
  ?contractingAuthority ?outP ?outO .
}
