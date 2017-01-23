PREFIX isvz:   <http://linked.opendata.cz/resource/dataset/isvz.cz>
PREFIX pc:     <http://purl.org/procurement/public-contracts#>

DELETE {
  GRAPH isvz: {
    ?lot pc:actualPrice ?actualPrice .
    ?actualPrice ?p ?o .
  }
}
WHERE {
  {
    SELECT ?lot (SAMPLE(?actualPrice) AS ?sampleActualPrice)
    WHERE {
      GRAPH isvz: {
        ?lot pc:actualPrice ?actualPrice .
      }
    }
    GROUP BY ?lot
    HAVING (COUNT(?actualPrice) > 1)
  }
  GRAPH isvz: {
    ?lot pc:actualPrice ?actualPrice .
    FILTER (!sameTerm(?actualPrice, ?sampleActualPrice))
    ?actualPrice ?p ?o .
  }
}
