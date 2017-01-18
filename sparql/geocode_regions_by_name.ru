PREFIX schema: <http://schema.org/>

WITH <http://linked.opendata.cz/resource/dataset/isvz.cz>
INSERT {
  ?place schema:address ?postalAddress .
}
WHERE {
  ?postalAddress schema:description ?description .
  ?place schema:geo [] ;
    schema:name ?name .
  FILTER CONTAINS(LCASE(?description), LCASE(?name))
}
