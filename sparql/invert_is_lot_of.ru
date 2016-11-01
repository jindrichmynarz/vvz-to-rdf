PREFIX pc:    <http://purl.org/procurement/public-contracts#>

DELETE {
  ?lot pc:isLotOf ?contract .
}
INSERT {
  ?contract pc:lot ?lot .
}
WHERE {
  ?lot pc:isLotOf ?contract .
}
