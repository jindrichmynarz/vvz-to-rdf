PREFIX ruian:  <http://ruian.linked.opendata.cz/ontology/>
PREFIX schema: <http://schema.org/>

WITH <http://linked.opendata.cz/resource/dataset/isvz.cz>
INSERT {
  ?place schema:address ?postalAddress .
}
WHERE {
  ?postalAddress schema:description ?description .
  ?place schema:geo [] ;
    ruian:nuts ?nuts .
  FILTER CONTAINS(LCASE(?description), LCASE(?nuts))
}
