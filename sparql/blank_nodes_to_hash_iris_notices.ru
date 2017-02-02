PREFIX isvz:  <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX pproc: <http://contsem.unizar.es/def/sector-publico/pproc#>

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
          [] isvz:notice ?bnode .
          FILTER isBlank(?bnode)
          ?bnode ?p ?o .
        }
        GROUP BY ?bnode
      }
      BIND ("http://linked.opendata.cz/resource/" AS ?ns)
      BIND (IRI(CONCAT(?ns, "notice/", ?hash)) AS ?iri)
    }
  }
  ?bnode ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?bnode .
  }
}
