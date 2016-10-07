PREFIX : <http://schema.org/>

DELETE {
  ?location1 ?outP ?outO .
  ?inS ?inP ?location1 .
}
INSERT {
  ?inS ?inP ?location2 .
}
WHERE {
  ?location1 a :Place .
  ?location2 a :Place .
  FILTER (!sameTerm(?location1, ?location2))
  FILTER NOT EXISTS {
    ?location1 ?p ?o .
    FILTER NOT EXISTS {
      ?location2 ?p ?o .
    }
  }
  ?location1 ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?location1 .
  }
}
