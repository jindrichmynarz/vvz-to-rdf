PREFIX pc:    <http://purl.org/procurement/public-contracts#>
PREFIX pproc: <http://contsem.unizar.es/def/sector-publico/pproc#>

DELETE {
  ?notice pc:isNoticeOf ?contract .
}
INSERT {
  ?contract pproc:notice ?notice .
}
WHERE {
  ?notice pc:isNoticeOf ?contract .
}
