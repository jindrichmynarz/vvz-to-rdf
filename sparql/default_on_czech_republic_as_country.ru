PREFIX schema: <http://schema.org/>

INSERT {
  ?postalAddress schema:addressCountry "CZ" .
}
WHERE {
  ?postalAddress a schema:PostalAddress .
  FILTER NOT EXISTS {
    ?postalAddress schema:addressCountry [] .
  }
}
