PREFIX schema: <http://schema.org/>

DELETE {
  ?priceSpecification schema:minPrice ?minPrice ;
    schema:maxPrice ?maxPrice .
}
INSERT {
  ?priceSpecification schema:price ?avgPrice .
}
WHERE {
  ?priceSpecification a schema:PriceSpecification ;
    schema:minPrice ?minPrice ;
    schema:maxPrice ?maxPrice .
  BIND ((?maxPrice - ?minPrice)/2.0 AS ?avgPrice)
}
