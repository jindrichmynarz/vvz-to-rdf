PREFIX activities: <http://purl.org/procurement/public-contracts-activities#>
PREFIX pc:         <http://purl.org/procurement/public-contracts#>
PREFIX skos:       <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?contractingAuthority pc:mainActivity ?_mainActivity .
  ?_mainActivity ?p ?o .
}
INSERT {
  ?contractingAuthority pc:mainActivity ?mainActivity .
}
WHERE {
  ?contractingAuthority pc:mainActivity ?_mainActivity .
  ?_mainActivity skos:prefLabel ?label .
  ?mainActivity skos:inScheme activities: ;
    skos:prefLabel ?label .
  ?_mainActivity ?p ?o .
}
