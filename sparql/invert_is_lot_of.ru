PREFIX pc:    <http://purl.org/procurement/public-contracts#>
PREFIX pproc: <http://contsem.unizar.es/def/sector-publico/pproc#>

DELETE {
  ?lot pc:isLotOf ?contract .
}
INSERT {
  ?contract pproc:lot ?lot .
}
WHERE {
  ?lot pc:isLotOf ?contract .
}
