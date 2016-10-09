PREFIX rov: <http://www.w3.org/ns/regorg#>

DELETE {
  ?organization ?outP ?outO .
  ?inS ?inP ?organization .
}
INSERT {
  ?sampleOrganization ?outP ?outO .
  ?inS ?inP ?sampleOrganization .
}
WHERE {
  {
    SELECT (SAMPLE(?organization) AS ?sampleOrganization) ?registration
    WHERE {
      ?organization rov:registration ?registration .
      FILTER (!isBlank(?organization))
    }
    GROUP BY ?registration
  }
  ?organization rov:registration ?registration .
  FILTER (!sameTerm(?organization, ?sampleOrganization))
  ?organization ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?organization .
  }
}
