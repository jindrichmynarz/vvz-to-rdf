PREFIX pc:   <http://purl.org/procurement/public-contracts#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?contract ?cpvProperty ?qualifiedCpv2003 .
  ?qualifiedCpv2003 ?p ?o .
}
INSERT {
  ?contract ?cpvProperty ?qualifiedCpv2008 .
}
WHERE {
  VALUES ?cpvProperty {
    pc:additionalObject
    pc:mainObject
  }
  ?contract a pc:Contract ;
    ?cpvProperty ?qualifiedCpv2003 .
  ?qualifiedCpv skos:closeMatch ?cpv2003 ;
    ?p ?o .
  ?cpv2003 skos:exactMatch ?qualifiedCpv2008 .
}
