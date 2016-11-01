PREFIX schema: <http://schema.org/>

DELETE {
  ?organization schema:legalName ?_name .
}
INSERT {
  ?organization schema:legalName ?name .
}
WHERE {
  ?organization a schema:Organization ;
    schema:legalName ?_name .
  BIND (REPLACE(REPLACE(?_name, "a\\.\\s*s\\.\\s*", "a.s."),
                                "(spol\\.\\s+)?s\\.\\s*r\\.\\s*?o\\.\\s*", "s.r.o.") AS ?name)
}
