PREFIX adms:    <http://www.w3.org/ns/adms#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX rov:     <http://www.w3.org/ns/regorg#>
PREFIX schema:  <http://schema.org/>
PREFIX skos:    <http://www.w3.org/2004/02/skos/core#>
PREFIX xsd:     <http://www.w3.org/2001/XMLSchema#>

DELETE {
  ?identifier dcterms:valid false .
}
INSERT {
  ?identifier skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/CZ-ICO> .
}
WHERE {
  ?identifier a adms:Identifier ;
    dcterms:valid false ;
    skos:notation ?ico .
  [] schema:address/schema:addressCountry "CZ" ;
    rov:registration ?identifier .
  FILTER REGEX(?ico, "^\\d{8}$")

  BIND (STRDT(SUBSTR(?ico, 1, 1), xsd:integer) AS ?firstDigit)
  BIND (STRDT(SUBSTR(?ico, 2, 1), xsd:integer) AS ?secondDigit)
  BIND (STRDT(SUBSTR(?ico, 3, 1), xsd:integer) AS ?thirdDigit)
  BIND (STRDT(SUBSTR(?ico, 4, 1), xsd:integer) AS ?fourthDigit)
  BIND (STRDT(SUBSTR(?ico, 5, 1), xsd:integer) AS ?fifthDigit)
  BIND (STRDT(SUBSTR(?ico, 6, 1), xsd:integer) AS ?sixthDigit)
  BIND (STRDT(SUBSTR(?ico, 7, 1), xsd:integer) AS ?seventhDigit)
  BIND (STRDT(SUBSTR(?ico, 8, 1), xsd:integer) AS ?eighthDigit)
  BIND ((
    ?firstDigit * 8 + ?secondDigit * 7 + ?thirdDigit * 6
  + ?fourthDigit * 5 + ?fifthDigit * 4 + ?sixthDigit * 3
  + ?seventhDigit * 2
  ) AS ?sum)
  BIND ((?sum - (FLOOR(?sum/11) * 11)) AS ?modulo)
  BIND (IF(?modulo IN (0, 10), 1,
        IF(?modulo = 1, 0, 11 - ?modulo)
  ) AS ?checkDigit)
  FILTER (?eighthDigit = ?checkDigit) 
}
