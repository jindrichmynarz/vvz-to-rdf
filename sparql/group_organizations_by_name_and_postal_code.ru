PREFIX rov:    <http://www.w3.org/ns/regorg#>
PREFIX schema: <http://schema.org/>
PREFIX skos:   <http://www.w3.org/2004/02/skos/core#>

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
    SELECT ?name ?postalCode (SAMPLE(?organization) AS ?sampleOrganization)
    WHERE {
      ?organization a schema:Organization ;
        schema:address/schema:postalCode ?postalCode ;
        schema:name|schema:legalName ?name .
      FILTER NOT EXISTS {
        ?organization rov:registration/skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/CZ-ICO> .
      }
    }
    GROUP BY ?name ?postalCode
    HAVING (COUNT(DISTINCT ?organization) > 1)
  }
  ?organization a schema:Organization ;
    schema:address/schema:postalCode ?postalCode ;
    schema:name|schema:legalName ?name .
  FILTER NOT EXISTS {
    ?organization rov:registration/skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/CZ-ICO> .
  }
  FILTER (!sameTerm(?organization, ?sampleOrganization)) 
  ?organization ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?organization .
  }
}
