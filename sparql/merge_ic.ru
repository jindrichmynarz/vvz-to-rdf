PREFIX rov: <http://www.w3.org/ns/regorg#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?organization rov:registration ?registration .
  ?registration ?p ?o .
}
WHERE {
  {
    SELECT ?organization ?ic
    WHERE {
      ?organization rov:registration ?registration .
      ?registration skos:notation ?ic ;
        skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/CZ-ICO> .
    }
    GROUP BY ?organization ?ic
    HAVING (COUNT(?registration) > 1)
  }
  ?organization rov:registration ?registration .
  ?registration skos:notation ?ic ;
    skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/CZ-ICO> .
  FILTER (STR(?registration) != CONCAT("http://linked.opendata.cz/resource/isvz.cz/identifier/", ?ic))
  ?registration ?p ?o .
}
