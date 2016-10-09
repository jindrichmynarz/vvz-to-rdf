PREFIX schema: <http://schema.org/>

DELETE {
  ?s schema:url ?_url .
}
INSERT {
  ?s schema:url ?url .
}
WHERE {
  ?s schema:url ?_url .
  FILTER STRENDS(?_url, "/")
  BIND (REPLACE(?_url, "^(.*)\\/+$", "$1") AS ?url)
}
