PREFIX authkinds: <http://purl.org/procurement/public-contracts-authority-kinds#>
PREFIX pc:        <http://purl.org/procurement/public-contracts#>
PREFIX skos:      <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?contractingAuthority pc:authorityKind ?_authorityKind .
  ?_authorityKind ?p ?o .
}
INSERT {
  ?contractingAuthority pc:authorityKind ?authorityKind .
}
WHERE {
  ?contractingAuthority pc:authorityKind ?_authorityKind .
  ?_authorityKind skos:prefLabel ?label .
  ?authorityKind skos:inScheme authkinds: ;
    skos:prefLabel ?label .
  ?_authorityKind ?p ?o .
}
