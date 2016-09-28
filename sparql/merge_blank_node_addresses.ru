PREFIX schema: <http://schema.org/>

DELETE {
  ?s schema:address ?address2 .
  ?address2 ?p ?o .
}
WHERE {
  ?s schema:address ?address1, ?address2 .
  FILTER (!sameTerm(?address1, ?address2) && isBlank(?address1) && isBlank(?address2))
  FILTER NOT EXISTS {
    ?address1 ?p ?o .
    FILTER NOT EXISTS {
      ?address2 ?p ?o .
    }
  }
  ?address2 ?p ?o .
}
