PREFIX kinds:     <http://purl.org/procurement/public-contracts-kinds#>
PREFIX pc:        <http://purl.org/procurement/public-contracts#>
PREFIX skos:      <http://www.w3.org/2004/02/skos/core#>

DELETE {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?_kind ?outP ?outO .
    ?inS ?inP ?_kind .
  }
}
INSERT {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?inS ?inP ?kind .
  }
}
WHERE {
  {
    SELECT DISTINCT ?_kind ?label ?kind
    WHERE {
      {
        SELECT DISTINCT ?_kind ?label
        WHERE {
          GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
            [] pc:kind ?_kind .
            ?_kind skos:prefLabel ?label .
          }
        }
      }
      GRAPH <http://purl.org/procurement/public-contracts-kinds> {
        ?kind skos:inScheme kinds: ;
          skos:prefLabel ?label .
      }
    }
  }
  ?_kind ?outP ?outO .
  ?inS ?inP ?_kind .
}
