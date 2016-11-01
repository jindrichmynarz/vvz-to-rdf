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
               ?class
               (SHA1(CONCAT(GROUP_CONCAT(STR(?outP); separator = ""),
                            GROUP_CONCAT(STR(?outO); separator = ""),
                            GROUP_CONCAT(STR(?inS); separator = ""),
                            GROUP_CONCAT(STR(?inP); separator = ""))) AS ?hash)
        WHERE {
          {
            SELECT DISTINCT ?bnode
            WHERE {
              ?bnode ?p [] .
              FILTER isBlank(?bnode)
            }
          }
          ?bnode a ?class ;
            ?outP ?outO .
          OPTIONAL {
            ?inS ?inP ?bnode .
          }
        }
        GROUP BY ?bnode ?class
      }
      # Your base namespace for resources: 
      BIND ("http://linked.opendata.cz/resource/" AS ?ns)
      # Extract the local name of the resource's class and convert it to kebab-case.
      BIND (LCASE(REPLACE(COALESCE(REPLACE(STR(?class), "^.*[/#]([^/#]+)$", "$1"), "thing"),
                          "(\\p{Ll})(\\p{Lu})", "$1-$2"))
           AS ?classLocalName)
      # The newly minted hash-based IRIs follow the pattern {namespace}/{class name}/{hash}.
      BIND (IRI(CONCAT(?ns, ?classLocalName, "/", ?hash)) AS ?iri)
    }
  }
  ?bnode ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?bnode .
  }
}
