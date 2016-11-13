PREFIX schema: <http://schema.org/>

DELETE {
  ?postalAddress ?p ?o .
}
WHERE {
  ?postalAddress a schema:PostalAddress .
  FILTER NOT EXISTS {
    [] ?inP ?postalAddress .
  }
  ?postalAddress ?p ?o .
}
