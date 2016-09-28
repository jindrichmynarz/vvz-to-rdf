DELETE {
  ?s ?p ?_o .
}
INSERT {
  ?s ?p ?o .
}
WHERE {
  ?s ?p ?_o .
  FILTER (isLiteral(?_o) && strstarts(?_o, "\"") && strends(?_o, "\""))
  BIND (substr(?_o, 2, strlen(?_o) - 1) AS ?o)
}
