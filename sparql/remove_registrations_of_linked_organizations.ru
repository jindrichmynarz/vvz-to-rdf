PREFIX rov:    <http://www.w3.org/ns/regorg#>
PREFIX schema: <http://schema.org/>

WITH <http://linked.opendata.cz/resource/dataset/isvz.cz>
DELETE {
  ?organization rov:registration ?registration .
  ?registration ?p ?o .
}
WHERE {
  ?organization a schema:Organization .
  FILTER (STRSTARTS(STR(?organization), "http://linked.opendata.cz/resource/business-entity/CZ"))
  ?organization rov:registration ?registration .
  ?registration ?p ?o .
}
