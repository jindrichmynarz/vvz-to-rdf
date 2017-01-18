PREFIX isvz:  <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX pproc: <http://contsem.unizar.es/def/sector-publico/pproc#>
PREFIX rdfs:  <http://www.w3.org/2000/01/rdf-schema#>

DELETE {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?notice a ?class .
  }
}
INSERT {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?contract a ?class .
  }
}
WHERE {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?contract isvz:notice ?notice .
    ?notice a ?class .
  }
  FILTER NOT EXISTS {
    GRAPH <http://contsem.unizar.es/def/sector-publico/pproc> {
      ?class rdfs:subClassOf pproc:Notice .
    }
  }
}
