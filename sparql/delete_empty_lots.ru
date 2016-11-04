PREFIX isvz:  <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX pc:    <http://purl.org/procurement/public-contracts#>
PREFIX pproc: <http://contsem.unizar.es/def/sector-publico/pproc#>
PREFIX rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

DELETE {
  ?lot ?p ?o .
}
WHERE {
  {
    SELECT DISTINCT ?lot
    WHERE {
      ?lot a pproc:Lot .
      FILTER NOT EXISTS {
        ?lot !(rdf:type|isvz:isLotOf) [] .
      }
    }
  }
  ?lot ?p ?o .
}
