PREFIX adms:    <http://www.w3.org/ns/adms#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX rov:     <http://www.w3.org/ns/regorg#>
PREFIX schema:  <http://schema.org/>
PREFIX skos:    <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?identifier skos:notation ?_ico .
}
INSERT {
  ?identifier skos:notation ?ico .
}
WHERE {
  ?identifier a adms:Identifier ;
    dcterms:valid false ;
    skos:notation ?_ico .
  [] schema:address/schema:addressCountry "CZ" ;
    rov:registration ?identifier .
  FILTER REGEX(?_ico, "[^\\d]")
  BIND (REPLACE(?_ico, "[^\\d]", "") AS ?ico) 
}

