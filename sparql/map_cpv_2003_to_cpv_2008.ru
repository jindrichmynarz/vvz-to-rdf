PREFIX pc:   <http://purl.org/procurement/public-contracts#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?contract ?cpvProperty ?cpv2003 .
}
INSERT {
  ?contract ?cpvProperty ?cpv2008 .
}
WHERE {
  VALUES ?cpvProperty {
    pc:additionalObject
    pc:mainObject
  }
  ?contract a pc:Contract ;
    ?cpvProperty ?cpv2003 .
  ?cpv2003 skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/cpv-2003> ;
    skos:exactMatch ?cpv2008 .
}
