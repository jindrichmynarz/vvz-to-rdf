PREFIX pc:        <http://purl.org/procurement/public-contracts#>
PREFIX skos:      <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?contract pc:procedureType ?broader .
}
WHERE {
  ?contract pc:procedureType ?narrower, ?broader .
  ?narrower skos:broader ?broader .
}
