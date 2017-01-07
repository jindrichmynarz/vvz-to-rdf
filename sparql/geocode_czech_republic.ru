PREFIX schema: <http://schema.org/>

WITH <http://linked.opendata.cz/resource/dataset/isvz.cz>
INSERT {
  [] schema:address ?postalAddress ;
    schema:geo [
      schema:latitude 49.74375 ;
      schema:longitude 15.338639
    ] .
}
WHERE {
  VALUES ?czechRepublic {
    "Česká republika"
    "CZ - Česká republika"
    "CZ"
  }
  ?postalAddress a schema:PostalAddress ;
    schema:description ?czechRepublic .
}
