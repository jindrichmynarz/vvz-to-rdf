PREFIX scheme: <http://linked.opendata.cz/resource/concept-scheme/eur-lex.europa.eu/service-categories>
PREFIX pc:     <http://purl.org/procurement/public-contracts#>
PREFIX skos:   <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?contract pc:serviceCategory ?_serviceCategory .
  ?_serviceCategory ?p ?o .
}
INSERT {
  ?contract pc:serviceCategory ?serviceCategory .
}
WHERE {
  ?contract pc:serviceCategory ?_serviceCategory .
  ?_serviceCategory skos:prefLabel ?label .
  ?serviceCategory skos:inScheme scheme: ;
    skos:prefLabel ?label .
  ?_serviceCategory ?p ?o .
}
