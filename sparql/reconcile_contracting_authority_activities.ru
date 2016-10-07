PREFIX activities: <http://purl.org/procurement/public-contracts-activities#>
PREFIX pc:         <http://purl.org/procurement/public-contracts#>
PREFIX skos:       <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?_mainActivity ?outP ?outO .
  ?inS ?inP ?_mainActivity .
}
INSERT {
  ?inS ?inP ?mainActivity .
}
WHERE {
  ?contractingAuthority pc:mainActivity ?_mainActivity .
  ?_mainActivity skos:prefLabel ?label .
  ?mainActivity skos:inScheme activities: ;
    skos:prefLabel ?label .
  ?_mainActivity ?outP ?outO .
  ?inS ?inP ?_mainActivity .
}
