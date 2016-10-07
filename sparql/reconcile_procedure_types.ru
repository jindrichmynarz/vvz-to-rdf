PREFIX proctypes: <http://purl.org/procurement/public-contracts-procedure-types#>
PREFIX pc:        <http://purl.org/procurement/public-contracts#>
PREFIX skos:      <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?_procedureType ?outP ?outO .
  ?inS ?inP ?_procedureType .
}
INSERT {
  ?inS ?inP ?procedureType .
}
WHERE {
  ?contract pc:procedureType ?_procedureType .
  ?_procedureType skos:prefLabel ?label .
  ?procedureType skos:inScheme proctypes: ;
    skos:prefLabel ?label .
  ?_procedureType ?outP ?outO .
  ?inS ?inP ?_procedureType .
}
