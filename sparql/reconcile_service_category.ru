PREFIX isvz:   <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX scheme: <http://linked.opendata.cz/resource/concept-scheme/eur-lex.europa.eu/service-categories>
PREFIX skos:   <http://www.w3.org/2004/02/skos/core#>

DELETE {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?_serviceCategory ?outP ?outO .
    ?inS ?inP ?_serviceCategory .
  }
}
INSERT {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?inS ?inP ?serviceCategory .
  }
}
WHERE {
  {
    SELECT ?_serviceCategory ?label ?serviceCategory
    WHERE {
      {
        SELECT DISTINCT ?_serviceCategory ?label
        WHERE {
          GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
            [] isvz:serviceCategory ?_serviceCategory .
            ?_serviceCategory skos:prefLabel ?label .
          }
        }
      }
      GRAPH scheme: {
        ?serviceCategory skos:inScheme scheme: ;
          skos:prefLabel ?label .
      }
    }
  }
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?_serviceCategory ?outP ?outO .
    ?inS ?inP ?_serviceCategory .
  }
}
