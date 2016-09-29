PREFIX foaf: <http://xmlns.com/foaf/0.1/>
PREFIX pc:   <http://purl.org/procurement/public-contracts#>

DELETE {
  ?contract pc:subsidy ?_project .
  ?_project ?p ?o .
}
INSERT {
  ?contract pc:subsidy ?project .
  ?project ?p ?o .
}
WHERE {
  ?contract pc:isFundedFromEUProject true ;
    pc:subsidy ?_project .
  ?_project foaf:name ?name .
  FILTER REGEX(?name, "^.*CZ\\.\\d+\\.\\d+\\/\\d+\\.\\d+\\.\\d+\\/\\d+\\.\\d+.*$")

  BIND (REPLACE(?name, "^.*(CZ\\.\\d+\\.\\d+\\/\\d+\\.\\d+\\.\\d+\\/\\d+\\.\\d+.)*$", $1) AS ?notation)
  BIND ("http://data.openbudgets.eu/resource/dataset/esf-czech-projects/" AS ?ns)
  BIND (REPLACE(?notation, "\\.|\\/", "-") AS ?notationSlug)
  BIND (IRI(CONCAT(?ns, "project/", ?notationSlug)) AS ?project)

  ?_project ?p ?o .
}
