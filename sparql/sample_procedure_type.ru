# Randomly selects a procedure type for contracts that have more than one procedure type.
# Usually, this is a bad idea, but there are only few such contracts in VVZ, so the impact is small.

PREFIX isvz:   <http://linked.opendata.cz/resource/dataset/isvz.cz>
PREFIX pc:     <http://purl.org/procurement/public-contracts#>

DELETE {
  GRAPH isvz: {
    ?contract pc:procedureType ?procedureType .
  }
}
WHERE {
  {
    SELECT ?contract (SAMPLE(?procedureType) AS ?sampleProcedureType)
    WHERE {
      GRAPH isvz: {
        ?contract pc:procedureType ?procedureType .
      }
    }
    GROUP BY ?contract
    HAVING (COUNT(?procedureType) > 1)
  }
  GRAPH isvz: {
    ?contract pc:procedureType ?procedureType .
    FILTER (!sameTerm(?procedureType, ?sampleProcedureType))
  }
}
