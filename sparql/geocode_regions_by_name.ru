PREFIX ruian:  <http://ruian.linked.opendata.cz/ontology/>
PREFIX schema: <http://schema.org/>

WITH <http://linked.opendata.cz/resource/dataset/isvz.cz>
INSERT {
  ?place schema:address ?postalAddress .
}
WHERE {
  ?postalAddress schema:description ?name .
  VALUES ?class {
    ruian:Obec
    ruian:Vusc
  }
  ?place a ?class ;
    schema:geo [] ;
    schema:name ?name .
}
