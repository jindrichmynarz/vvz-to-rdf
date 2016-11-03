PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?cpv2003 ?p ?o .
}
WHERE {
  ?cpv2003 skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/cpv-2003> ;
    ?p ?o .
}
