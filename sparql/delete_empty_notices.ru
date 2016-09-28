PREFIX pc:    <http://purl.org/procurement/public-contracts#>
PREFIX pproc: <http://contsem.unizar.es/def/sector-publico/pproc#>
PREFIX rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

DELETE {
  ?notice ?p ?o .
}
WHERE {
  ?notice a pproc:Notice .
  FILTER NOT EXISTS {
    ?notice !(rdf:type|pc:isNoticeOf|pc:isValid) [] .
  }
  ?notice ?p ?o .
}
