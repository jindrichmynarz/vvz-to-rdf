PREFIX isvz: <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX pc:   <http://purl.org/procurement/public-contracts#>

DELETE {
  ?lot isvz:isLotOf ?contract .
}
INSERT {
  ?contract pc:lot ?lot .
}
WHERE {
  ?lot isvz:isLotOf ?contract .
}
