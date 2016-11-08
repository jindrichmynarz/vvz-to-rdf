PREFIX :        <http://linked.opendata.cz/resource/code-list/public-procurement-forms-2004/>
PREFIX czpf:    <http://linked.opendata.cz/resource/code-list/public-procurement-forms-2004/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX isvz:    <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX pc:      <http://purl.org/procurement/public-contracts#>
PREFIX pccz:    <http://purl.org/procurement/public-contracts-czech#>
PREFIX skos:    <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?olderNotice ?functionalProperty ?oldO .
}
WHERE {
  {
    SELECT ?newerNotice ?olderNotice 
    WHERE {
      # Order can be "learnt" from the most common order of notices with following submission dates.
      VALUES (?olderType ?newerType) {
        (:f01 :f02)
        (:f02 :f03)
        (:f01 :f03)
        (:f02 czpf:f51)
        (:f03 czpf:f54)
        (:f02 czpf:f54)
        (:f01 czpf:f51)
        (:f09 :f03)
        # (czpf:f51 :f03) -> An award notice after a cancellation notice doesn't make sense.
        (:f05 :f06)
        (:f01 czpf:f54)
        (czpf:f52 czpf:f53)
        (:f09 czpf:f51)
        # (czpf:f51 czpf:f54) -> An award notice after a cancellation notice doesn't make sense.
        (:f05 czpf:f51)
        (:f05 czpf:f54)
        (:f06 czpf:f54)
        (:f03 czpf:f51)
        (:f12 :f13)
        (:f15 :f03)
        # (czpf:f51 :f02) -> A contract notice after a cancellation notice doesn't make sense.
        (:f01 :f15)
        (:f16 :f17)
        (:f16 :f18)
        # (czpf:f54 :f02) -> A contract notice after an award notice doesn't make sense.
        (:f02 :f06)
        (:f17 :f18)
        (:f09 czpf:f54)
        (:f17 czpf:f51)
        # (:f03 :f02) -> An award notice after a contract notice doesn't make sense.
        (czpf:f54 czpf:f51)
        # (:f02 :f01) -> A contract notice after a prior information notice doesn't make sense.
      }
      [] isvz:notice ?olderNotice, ?newerNotice .
      FILTER (!sameTerm(?olderNotice, ?newerNotice))
      ?olderNotice dcterms:dateSubmitted ?d ;
        dcterms:type ?olderType .
      ?newerNotice dcterms:dateSubmitted ?d ;
        dcterms:type ?newerType .
    }
  }
  VALUES ?functionalProperty {
    dcterms:description
    dcterms:title
    isvz:highestConsideredBidPrice
    isvz:isElectronicAuction
    isvz:isFundedFromEUProject
    isvz:isGovernmentProcurementAgreement
    isvz:lowestConsideredBidPrice
    isvz:mainCriterion
    isvz:serviceCategory
    pc:actualPrice
    pc:awardCriteriaCombination
    pc:contractingAuthority
    pc:estimatedPrice
    pc:kind
    pc:location
    pc:mainObject
    pc:procedureType
    pccz:limit
  }
  ?newerNotice ?functionalProperty ?newO .
  ?olderNotice ?functionalProperty ?oldO .
  FILTER (!sameTerm(?newO, ?oldO))
}
