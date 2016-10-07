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
               (SHA1(CONCAT(GROUP_CONCAT(STR(?p); separator = ""),
                            GROUP_CONCAT(STR(?o); separator = ""))) AS ?hash)
        WHERE {
          ?bnode a skos:Concept ;
            skos:prefLabel [] .
          FILTER isBlank(?bnode)
          ?bnode ?p ?o .
        }
        GROUP BY ?bnode
      }
      BIND ("http://linked.opendata.cz/resource/" AS ?ns)
      BIND (IRI(CONCAT(?ns, "concept/", ?hash)) AS ?iri)
    }
  }
  ?bnode ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?bnode .
  }
}
