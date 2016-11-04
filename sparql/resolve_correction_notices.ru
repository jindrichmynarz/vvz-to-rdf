PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX isvz:    <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX pproc:   <http://contsem.unizar.es/def/sector-publico/pproc#>
PREFIX rdf:     <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

DELETE {
  ?olderNotice ?p ?o .
}
WHERE {
  {
    SELECT ?contract ?correctionNotice ?olderNotice 
    WHERE {
      ?contract isvz:notice ?correctionNotice, ?olderNotice .
      ?correctionNotice a pproc:CorrectionNotice ;
        dcterms:dateSubmitted ?correctionNoticeDate .
      ?olderNotice dcterms:dateSubmitted ?olderNoticeDate .
      FILTER (!sameTerm(?correctionNotice, ?olderNotice)
              &&
              ?correctionNoticeDate > ?olderNoticeDate)

    }
  }
  ?correctionNotice ?p ?correctedO .
  FILTER (?p NOT IN (dcterms:dateSubmitted, dcterms:issued, dcterms:type, rdf:type))
  ?olderNotice ?p ?o .
}
