PREFIX schema: <http://schema.org/>

INSERT {
  ?priceSpecification schema:priceCurrency "CZK" .
}
WHERE {
  ?priceSpecification a schema:PriceSpecification .
  FILTER NOT EXISTS {
    ?priceSpecification schema:priceCurrency [] .
  }
}
