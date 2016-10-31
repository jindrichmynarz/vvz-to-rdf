PREFIX rov:    <http://www.w3.org/ns/regorg#>
PREFIX schema: <http://schema.org/>
PREFIX skos:   <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?organization ?p ?o .
  ?o ?addressP ?addressO .
}
WHERE {
  {
    SELECT DISTINCT ?organization
    WHERE {
      ?organization a schema:Organization ;
        rov:registration [
          skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/CZ-ICO> ;
          skos:notation []
        ] ;
        schema:address|schema:legalName [] .
    }
  }
  VALUES ?p {
    schema:address
    schema:legalName
  }
  ?organization ?p ?o .
  OPTIONAL {
    ?o a schema:PostalAddress ;
      ?addressP ?addressO .
  }
}
