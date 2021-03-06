PREFIX rov:  <http://www.w3.org/ns/regorg#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?bnode ?outP ?outO .
  ?inS ?inP ?bnode .
}
INSERT {
  ?iri ?outP ?outO .
  ?inS ?inP ?iri .
}
WHERE {
  ?bnode rov:registration [
    skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/CZ-ICO> ;
    skos:notation ?ico
  ] .
  FILTER isBlank(?bnode)
  BIND (IRI(CONCAT("http://linked.opendata.cz/resource/business-entity/CZ", ?ico)) AS ?iri)
  ?bnode ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?bnode .
  }
}
