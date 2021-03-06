PREFIX geo:    <http://www.w3.org/2003/01/geo/wgs84_pos#>
PREFIX schema: <http://schema.org/>

WITH <http://linked.opendata.cz/resource/dataset/isvz.cz>
INSERT {
  ?organization geo:geometry ?point .
}
WHERE {
  {
    SELECT ?organization ?geo
    WHERE {
      ?organization a schema:Organization ;
        schema:address/^schema:address/schema:geo ?geo .
      FILTER NOT EXISTS {
        ?organization geo:geometry [] .
      }
    }
  }
  ?geo schema:latitude ?latitude ;
    schema:longitude ?longitude .
  BIND (CONCAT("POINT(", STR(?longitude), " ", STR(?latitude), ")") AS ?point)
}
