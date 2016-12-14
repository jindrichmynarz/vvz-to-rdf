PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX rov:     <http://www.w3.org/ns/regorg#>
PREFIX skos:    <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?organization rov:registration ?invalidIco .
  ?invalidIco ?p ?o .
}
WHERE {
  {
    SELECT ?organization ?invalidIco
    WHERE {
      ?organization rov:registration ?validIco, ?invalidIco .
      ?validIco skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/CZ-ICO> .
      ?invalidIco dcterms:valid false .
    }
  }
  ?invalidIco ?p ?o .
}
