PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?contract pc:onBehalfOf ?organization .
  ?organization ?p ?o .
}
WHERE {
  {
    SELECT ?contract (SAMPLE(?organization) AS ?sampleOrganization)
    WHERE {
      ?contract a pc:Contract ;
        pc:onBehalfOf ?organization .
    }
    GROUP BY ?contract
    HAVING (COUNT(?organization) > 1)
  }
  ?contract pc:onBehalfOf ?organization .
  FILTER (!sameTerm(?organization, ?sampleOrganization))
  ?organization ?p ?o .
}
