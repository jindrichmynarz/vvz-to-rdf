PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

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
               (SHA1(CONCAT(GROUP_CONCAT(STR(?outP); separator = ""),
                            GROUP_CONCAT(STR(?outO); separator = ""),
                            GROUP_CONCAT(STR(?inS); separator = ""),
                            GROUP_CONCAT(STR(?inP); separator = ""))) AS ?hash)
        WHERE {
          {
            SELECT DISTINCT ?bnode
            WHERE {
              ?bnode a skos:Concept .
              FILTER isBlank(?bnode)
            }
          }
          ?bnode ?outP ?outO .
          OPTIONAL {
            ?inS ?inP ?bnode .
          }
        }
        GROUP BY ?bnode
      }
      BIND (IRI(CONCAT("http://linked.opendata.cz/resource/concept/", ?hash)) AS ?iri)
    }
  }
  ?bnode ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?bnode .
  }
}
