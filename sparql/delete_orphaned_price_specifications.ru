PREFIX schema: <http://schema.org/>

DELETE {
  ?priceSpecification ?p ?o .
}
WHERE {
  ?priceSpecification a schema:PriceSpecification .
  FILTER NOT EXISTS {
    [] ?inP ?priceSpecification .
  }
  ?priceSpecification ?p ?o .
}
