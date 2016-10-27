PREFIX schema: <http://schema.org/>

DELETE {
  ?organization schema:name ?_name .
}
INSERT {
  ?organization schema:name ?name .
}
WHERE {
  ?organization a schema:Organization ;
    schema:name ?_name .
  BIND (REPLACE(REPLACE(?_name, "a\\.\\s*s\\.\\s*", "a.s."),
                                "(spol\\.\\s+)?s\\.\\s*r\\.\\s*?o\\.\\s*", "s.r.o.") AS ?name)
}
