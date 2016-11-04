PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX isvz:    <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX pc:      <http://purl.org/procurement/public-contracts#>
PREFIX pccz:    <http://purl.org/procurement/public-contracts-czech#>

DELETE {
  ?olderNotice ?functionalProperty ?oldO .
}
WHERE {
  {
    SELECT ?newerNotice ?olderNotice 
    WHERE {
      [] isvz:notice ?newerNotice, ?olderNotice .
      ?newerNotice dcterms:dateSubmitted ?newerDate .
      ?olderNotice dcterms:dateSubmitted ?olderDate .
      FILTER (!sameTerm(?newerNotice, ?olderNotice)
              &&
              ?newerDate > ?olderDate)
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
