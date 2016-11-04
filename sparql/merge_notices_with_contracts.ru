PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX isvz:    <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

DELETE {
  ?notice ?p ?o .
}
INSERT {
  ?contract ?p ?o .
}
WHERE {
  {
    SELECT ?contract ?notice
    WHERE {
      ?contract isvz:notice ?notice .
    }
  }
  ?notice ?p ?o .
  FILTER (?p NOT IN (dcterms:dateSubmitted, dcterms:issued, dcterms:type, rdf:type))
}
