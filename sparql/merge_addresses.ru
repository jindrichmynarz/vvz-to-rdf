PREFIX schema: <http://schema.org/>

DELETE {
  ?s schema:address ?address1 .
  ?address1 ?outP ?outO .
  ?inS ?inP ?address1 .
}
INSERT {
  ?inS ?inP ?address2 .
}
WHERE {
  ?s schema:address ?address1, ?address2 .
  FILTER (!sameTerm(?address1, ?address2)) 
  FILTER NOT EXISTS {
    ?address1 ?p ?o .
    FILTER NOT EXISTS {
      ?address2 ?p ?o .
    }
  }
  ?address1 ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?address1 .
  }
}
