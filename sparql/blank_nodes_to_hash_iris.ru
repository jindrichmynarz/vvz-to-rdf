DELETE {
  ?bnode ?outP ?outO .
  ?inS ?inP ?bnode .
}
INSERT {
  ?iri ?outP ?outO .
  ?inS ?inP ?iri .
}
WHERE {
  {
    SELECT ?bnode ?iri
    WHERE {
      {
        SELECT ?bnode
               (SAMPLE(?_class) AS ?class)
               (SHA1(CONCAT(GROUP_CONCAT(STR(?p); separator = ""),
                            GROUP_CONCAT(STR(?o); separator = ""))) AS ?hash)
        WHERE {
          ?bnode ?p ?o .
          FILTER isBlank(?bnode)
          OPTIONAL {
            ?bnode a ?_class .
          }
        }
        GROUP BY ?bnode
      }
      BIND ("http://linked.opendata.cz/resource/" AS ?ns)
      BIND (LCASE(REPLACE(COALESCE(REPLACE(STR(?class), "^.*[/#]([^/#]+)$", "$1"), "thing"),
                          "(\\p{Ll})(\\p{Lu})", "$1-$2"))
           AS ?classLocalName)
      BIND (IRI(CONCAT(?ns, ?classLocalName, "/", ?hash)) AS ?iri)
    }
  }
  ?bnode ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?bnode .
  }
}
