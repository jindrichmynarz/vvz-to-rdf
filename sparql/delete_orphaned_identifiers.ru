PREFIX adms: <http://www.w3.org/ns/adms#>

DELETE {
  ?identifier ?p ?o .
}
WHERE {
  ?identifier a adms:Identifier .
  FILTER NOT EXISTS {
    [] ?inP ?identifier .
  }
  ?identifier ?p ?o .
}
