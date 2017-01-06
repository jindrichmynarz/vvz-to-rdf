PREFIX isvz:   <http://linked.opendata.cz/resource/dataset/isvz.cz>
PREFIX schema: <http://schema.org/>

WITH isvz:
DELETE {
  ?postalAddress schema:streetAddress ?addressLocality .
}
WHERE {
  ?postalAddress a schema:PostalAddress ;
    schema:streetAddress ?addressLocality ;
    schema:addressLocality ?addressLocality .
}
