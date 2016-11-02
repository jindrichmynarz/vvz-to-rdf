PREFIX isvz:   <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX scheme: <http://linked.opendata.cz/resource/concept-scheme/eur-lex.europa.eu/service-categories>
PREFIX skos:   <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?_serviceCategory ?outP ?outO .
  ?inS ?inP ?_serviceCategory .
}
INSERT {
  ?inS ?inP ?serviceCategory .
}
WHERE {
  ?contract isvz:serviceCategory ?_serviceCategory .
  ?_serviceCategory skos:prefLabel ?label .
  ?serviceCategory skos:inScheme scheme: ;
    skos:prefLabel ?label .
  ?_serviceCategory ?outP ?outO .
  ?inS ?inP ?_serviceCategory .
}
