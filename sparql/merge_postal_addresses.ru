PREFIX : <http://schema.org/>

DELETE {
  ?address1 ?outP ?outO .
  ?inS ?inP ?address1 .
}
INSERT {
  ?inS ?inP ?address2 .
}
WHERE {
  ?address1 a :PostalAddress .
  ?address2 a :PostalAddress .
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
