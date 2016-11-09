PREFIX isvz: <http://linked.opendata.cz/ontology/isvz.cz/>

DELETE {
  ?notice ?booleanProperty ?o .
}
WHERE {
  {
    SELECT ?contract ?booleanProperty
    WHERE {
      VALUES ?booleanProperty {
        isvz:isElectronicAuction
        isvz:isFundedFromEUProject
        isvz:isGovernmentProcurementAgreement
      }
      ?contract isvz:notice ?notice .
      ?notice ?booleanProperty ?o .
    }
    GROUP BY ?contract ?booleanProperty
    HAVING (COUNT(DISTINCT ?o) > 1)
  }
  ?contract isvz:notice ?notice .
  ?notice ?booleanProperty ?o .
}
