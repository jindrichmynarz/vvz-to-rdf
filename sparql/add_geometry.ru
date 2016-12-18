PREFIX geo:    <http://www.w3.org/2003/01/geo/wgs84_pos#>
PREFIX isvz:   <http://linked.opendata.cz/resource/dataset/isvz.cz>
PREFIX schema: <http://schema.org/>

INSERT {
  GRAPH isvz: {
    ?organization geo:geometry ?point .
  }
}
WHERE {
  {
    SELECT ?organization ?geo
    WHERE {
      GRAPH isvz: {
        ?organization a schema:Organization ;
          schema:address/^schema:address/schema:geo ?geo .
        FILTER NOT EXISTS {
          ?organization geo:geometry [] .
        }
      }
    }
  }
  GRAPH isvz: {
    ?geo schema:latitude ?latitude ;
      schema:longitude ?longitude .
    BIND (CONCAT("POINT(", STR(?longitude), " ", STR(?latitude), ")") AS ?point)
  }
}
