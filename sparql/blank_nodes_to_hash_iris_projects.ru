PREFIX foaf: <http://xmlns.com/foaf/0.1/>

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
               (SHA1(CONCAT(GROUP_CONCAT(STR(?p); separator = ""),
                            GROUP_CONCAT(STR(?o); separator = ""))) AS ?hash)
        WHERE {
          ?bnode a foaf:Project .
          FILTER isBlank(?bnode)
          ?bnode ?p ?o .
        }
        GROUP BY ?bnode
      }
      BIND ("http://linked.opendata.cz/resource/" AS ?ns)
      BIND (IRI(CONCAT(?ns, "project/", ?hash)) AS ?iri)
    }
  }
  ?bnode ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?bnode .
  }
}
