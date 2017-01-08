PREFIX schema: <http://schema.org/>

DELETE {
  ?priceSpecification schema:minPrice ?minPrice ;
    schema:maxPrice ?maxPrice .
}
INSERT {
  ?priceSpecification schema:minPrice ?maxPrice ;
    schema:maxPrice ?minPrice .
}
WHERE {
  ?priceSpecification schema:minPrice ?minPrice ;
    schema:maxPrice ?maxPrice .
  FILTER (?maxPrice < ?minPrice)
}
