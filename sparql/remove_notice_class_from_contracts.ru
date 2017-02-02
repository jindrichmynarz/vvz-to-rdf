PREFIX isvz:  <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX pproc: <http://contsem.unizar.es/def/sector-publico/pproc#>

WITH <http://linked.opendata.cz/resource/dataset/isvz.cz>
DELETE {
  ?contract a pproc:Notice .
}
WHERE {
  ?contract a pproc:Notice ;
    isvz:notice [] .
}
