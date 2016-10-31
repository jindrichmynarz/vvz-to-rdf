PREFIX adms:    <http://www.w3.org/ns/adms#>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX skos:    <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?identifier ?outP ?outO .
  ?inS ?inO ?identifier .
}
WHERE {
  ?identifier a adms:Identifier ;
    dcterms:valid false ;
    skos:notation "" .
  ?identifier ?outP ?outO .
  OPTIONAL {
    ?inS ?inO ?identifier .
  }
}

