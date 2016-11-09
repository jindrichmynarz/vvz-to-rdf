PREFIX isvz:    <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX pc:      <http://purl.org/procurement/public-contracts#>
PREFIX rov:     <http://www.w3.org/ns/regorg#>
PREFIX skos:    <http://www.w3.org/2004/02/skos/core#>

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
           (SAMPLE(?_registeredContractingAuthority) AS ?sampleContractingAuthority)
    WHERE {
      ?contract isvz:notice/pc:contractingAuthority ?_contractingAuthority, ?_registeredContractingAuthority .
      ?_registeredContractingAuthority rov:registration/skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/CZ-ICO> .
    }
    GROUP BY ?contract
    HAVING (COUNT(DISTINCT ?_contractingAuthority) > 1)
  }
  ?contract isvz:notice ?notice .
  ?notice pc:contractingAuthority ?contractingAuthority .
  FILTER (!sameTerm(?contractingAuthority, ?sampleContractingAuthority))
  ?contractingAuthority ?outP ?outO .
}
