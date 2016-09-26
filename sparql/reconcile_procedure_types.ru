PREFIX proctypes: <http://purl.org/procurement/public-contracts-procedure-types#>
PREFIX pc:        <http://purl.org/procurement/public-contracts#>
PREFIX skos:      <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?contract pc:procedureType ?_procedureType .
  ?_procedureType ?p ?o .
}
INSERT {
  ?contract pc:procedureType ?procedureType .
}
WHERE {
  ?contract pc:procedureType ?_procedureType .
  ?_procedureType skos:prefLabel ?label .
  ?procedureType skos:inScheme proctypes: ;
    skos:prefLabel ?label .
  ?_procedureType ?p ?o .
}
