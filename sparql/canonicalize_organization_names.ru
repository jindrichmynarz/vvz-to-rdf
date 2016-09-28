PREFIX schema: <http://schema.org/>

DELETE {
  ?organization schema:name ?_name .
}
INSERT {
  ?organization schema:name ?name .
}
WHERE {
  VALUES (?preferred ?alternative) {
         ("a.s." "a. s.")
         ("a.s." ",a.s.")
         ("s.r.o." "s. r. o.")
         ("s.r.o." "s.ro.")
         ("s.r.o." "spol. s r.o.")
         ("s.r.o." "spol. s.r.o.")
         ("s.r.o." "spol. s r. o.")
  }
  ?organization a schema:Organization ;
    schema:name ?_name .
  FILTER CONTAINS(?_name, ?alternative)
  BIND (REPLACE(?_name, ?alternative, ?preferred) AS ?name)
}
