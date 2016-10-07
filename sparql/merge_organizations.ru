PREFIX : <http://schema.org/>

DELETE {
  ?organization1 ?outP ?outO .
  ?inS ?inP ?organization1 .
}
INSERT {
  ?inS ?inP ?organization2 .
}
WHERE {
  ?organization1 a :Organization .
  ?organization2 a :Organization .
  FILTER (!sameTerm(?organization1, ?organization2))
  FILTER NOT EXISTS {
    ?organization1 ?p ?o .
    FILTER NOT EXISTS {
      ?organization2 ?p ?o .
    }
  }
  ?organization1 ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?organization1 .
  }
}
