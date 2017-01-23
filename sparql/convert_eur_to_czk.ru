PREFIX dcterms:        <http://purl.org/dc/terms/>
PREFIX isvz:           <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX schema:         <http://schema.org/>
PREFIX sdmx-dimension: <http://purl.org/linked-data/sdmx/2009/dimension#>
PREFIX sdmx-measure:   <http://purl.org/linked-data/sdmx/2009/measure#>
PREFIX xsd:            <http://www.w3.org/2001/XMLSchema#>

DELETE {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?priceSpecification schema:priceCurrency "EUR" ;
      schema:price ?price .
  }
}
INSERT {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?priceSpecification schema:priceCurrency "CZK" ;
      schema:price ?convertedPrice .
  }
}
WHERE {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?priceSpecification a schema:PriceSpecification ;
      schema:priceCurrency "EUR" .
    ?priceSpecification schema:price ?price .
    [] ?p ?priceSpecification ;
      isvz:notice/dcterms:dateSubmitted ?dateSubmitted .
  }
  BIND (IRI(CONCAT("http://reference.data.gov.uk/id/gregorian-day/", STR(?dateSubmitted))) AS ?date)

  GRAPH <http://data.openbudgets.eu/resource/dataset/ecb-exchange-rates> {
    [] sdmx-dimension:refPeriod ?date ;
      sdmx-dimension:currency <http://data.openbudgets.eu/codelist/currency/CZK> ;
      sdmx-measure:obsValue ?rate .
  }
  BIND (?price * ?rate AS ?convertedPrice)
}
