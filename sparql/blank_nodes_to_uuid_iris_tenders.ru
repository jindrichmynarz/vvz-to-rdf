PREFIX pc: <http://purl.org/procurement/public-contracts#>

DELETE {
  ?bnode ?outP ?outO .
  ?inS ?inP ?bnode .
}
INSERT {
  ?iri ?outP ?outO .
  ?inS ?inP ?iri .
}
WHERE {
  {
    SELECT ?bnode
           (IRI(CONCAT("http://linked.opendata.cz/resource/tender/", SHA256(STR(?bnode)))) AS ?iri)
    WHERE {
      [] pc:awardedTender ?bnode .
      FILTER isBlank(?bnode)
    }
  }
  ?bnode ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?bnode .
  }
}
