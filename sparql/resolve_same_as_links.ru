PREFIX owl: <http://www.w3.org/2002/07/owl#>

DELETE {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?nonpreferred ?outP ?outO .
    ?inS ?inP ?nonpreferred .
  }
}
INSERT {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?preferred ?outP ?outO .
    ?inS ?inP ?preferred .
  }
}
WHERE {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz/links> {
    ?nonpreferred owl:sameAs ?preferred .
  }
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?nonpreferred ?outP ?outO .
    OPTIONAL {
      ?inS ?inP ?nonpreferred .
    }
  }
}
