PREFIX adms:  <http://www.w3.org/ns/adms#>
PREFIX pc:    <http://purl.org/procurement/public-contracts#>
PREFIX pproc: <http://contsem.unizar.es/def/sector-publico/pproc#>
PREFIX rdf:   <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX skos:  <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?lot a pproc:Lot ;
    ?p ?o .
}
INSERT {
  ?contract a pc:Contract ;
    ?p ?o .
}
WHERE {
  {
    SELECT ?lot ?contract
    WHERE {
      {
        SELECT ?lot
        WHERE {
          ?lot a pproc:Lot .
          FILTER NOT EXISTS {
            [] pc:lot ?lot .
          }
        }
      }
      ?lot adms:identifier [
        skos:inScheme <http://linked.opendata.cz/resource/isvz.cz/concept-scheme/cisla-formulare-na-vvz> ;
        skos:notation ?id
      ] .
      BIND (IRI(CONCAT("http://linked.opendata.cz/resource/isvz.cz/contract/", ?id)) AS ?contract)
    }
  }
  ?lot ?p ?o .
  FILTER (!sameTerm(?p, rdf:type))
}
