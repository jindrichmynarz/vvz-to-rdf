PREFIX kinds: <http://purl.org/procurement/public-contracts-kinds#>
PREFIX pc:     <http://purl.org/procurement/public-contracts#>
PREFIX skos:   <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?contract pc:kind ?_kind .
  ?_kind ?p ?o .
}
INSERT {
  ?contract pc:kind ?kind .
}
WHERE {
  ?contract pc:kind ?_kind .
  ?_kind skos:prefLabel ?label .
  ?kind skos:inScheme kinds: ;
    skos:prefLabel ?label .
  ?_kind ?p ?o .
}
