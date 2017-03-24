PREFIX pc:   <http://purl.org/procurement/public-contracts#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

DELETE {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?contract ?cpvProperty ?qualifiedCpv2003 .
    ?qualifiedCpv2003 ?p2003 ?o2003 .
  }
}
INSERT {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?contract ?cpvProperty ?qualifiedCpv2008 .
    ?qualifiedCpv2008 ?p2008 ?o2008 .
  }
}
WHERE {
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    VALUES ?cpvProperty {
      pc:additionalObject
      pc:mainObject
    }
    ?contract ?cpvProperty ?qualifiedCpv2003 .
    ?qualifiedCpv2003 skos:closeMatch ?cpv2003ish .
  }
  FILTER NOT EXISTS {
    GRAPH <http://linked.opendata.cz/resource/concept-scheme/cpv-2008> {
      ?cpv2003ish a skos:Concept .
    }
  }
  BIND (IRI(REPLACE(STR(?cpv2003ish), "cpv-2008", "cpv-2003")) AS ?cpv2003)
  GRAPH <http://linked.opendata.cz/resource/linkset/cpv-2003-to-cpv-2008> {
    ?cpv2003 skos:exactMatch ?qualifiedCpv2008 .
    ?qualifiedCpv2008 ?p2008 ?o2008 .
  }
  GRAPH <http://linked.opendata.cz/resource/dataset/isvz.cz> {
    ?qualifiedCpv2003 ?p2003 ?o2003 .
  }
}
