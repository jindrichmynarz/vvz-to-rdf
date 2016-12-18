PREFIX adms:   <http://www.w3.org/ns/adms#>
PREFIX rov:    <http://www.w3.org/ns/regorg#>
PREFIX schema: <http://schema.org/>
PREFIX skos:   <http://www.w3.org/2004/02/skos/core#>

WITH <http://linked.opendata.cz/resource/dataset/isvz.cz>
INSERT {
  ?organization rov:registration ?registration . 
  ?registration a adms:Identifier ;
    skos:notation ?ico ;
    skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/CZ-ICO> .
}
WHERE {
  ?organization a schema:Organization .
  FILTER STRSTARTS(STR(?organization), "http://linked.opendata.cz/resource/business-entity/CZ")
  FILTER NOT EXISTS {
    ?organization rov:registration [] .
  }
  BIND (STRAFTER(STR(?organization), "http://linked.opendata.cz/resource/business-entity/CZ") AS ?ico)
  BIND (IRI(CONCAT("http://linked.opendata.cz/resource/isvz.cz/identifier/", ?ico)) AS ?registration)
}
