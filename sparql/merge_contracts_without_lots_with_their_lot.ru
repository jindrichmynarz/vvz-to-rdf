PREFIX pc:    <http://purl.org/procurement/public-contracts#>
PREFIX pproc: <http://contsem.unizar.es/def/sector-publico/pproc#>

DELETE {
  ?contract ?p ?o .
}
INSERT {
  ?lot ?p ?o .
}
WHERE {
  {
    SELECT ?contract
    WHERE {
      ?contract a pproc:ContractWithoutLots ;
        pc:lot ?lot .
    }
    GROUP BY ?contract
    HAVING (COUNT(?lot) > 1)
  }
  ?contract pc:lot ?lot ;
    ?p ?o .
}
