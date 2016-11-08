PREFIX :     <http://purl.org/procurement/public-contracts-procedure-types#>
PREFIX pc:   <http://purl.org/procurement/public-contracts#>
PREFIX pccz: <http://purl.org/procurement/public-contracts-czech#>
PREFIX skos: <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?notice pc:procedureType ?_procedureType .
  ?_procedureType ?p ?o .
}
INSERT {
  ?notice pc:procedureType ?procedureType .
}
WHERE {
  VALUES (?label ?procedureType) {
    ("Otevřené"@cs :Open)
    ("Vyjednávací bez zveřejnění oznámení o zakázce"@cs :NegotiatedWithoutCompetition)
    ("Jednací s výzvou k účasti v soutěži"@cs :NegotiatedWithCompetition)
    ("Jednací bez výzvy k účasti v soutěži"@cs :NegotiatedWithoutCompetition)
    ("Zjednodušené podlimitní řízení"@cs pccz:SimplifiedUnderLimit)
    ("Vyjednávací s výzvou k úcasti v souteži"@cs :NegotiatedWithCompetition)
    ("Užší"@cs :Restricted)
    ("Omezené"@cs :Restricted)
    ("Zadání zakázky bez předchozího zveřejnění oznámení o zakázce v Úředním věstníku Evropské unie (v případech uvedených v oddíle 2 přílohy D1)"@cs :AwardWithoutPriorPublication)
    ("Jednací s uveřejněním"@cs :NegotiatedWithCompetition)
    ("Vyjednávací"@cs :Negotiated)
    ("Bez předchozího zveřejnění"@cs :AwardWithoutPriorPublication)
    ("Jednací"@cs :Negotiated)
    ("Soutěžní dialog"@cs :CompetitiveDialogue)
    ("Urychlené omezené"@cs :AcceleratedRestricted)
    ("Urychlené vyjednávací"@cs :AcceleratedNegotiated)
    ("Zadání zakázky bez předchozího zveřejnění oznámení o zakázce v Úředním věstníku Evropské unie (v případech uvedených v oddíle 2 přílohy D2)"@cs :AwardWithoutPriorPublication)
    ("Urychlené užší"@cs :AcceleratedRestricted)
    ("Zadání zakázky bez předchozího zveřejnění oznámení o zakázce v Úředním věstníku Evropské unie (v případech uvedených v oddíle 2 přílohy D1, D2 nebo D3)"@cs :AwardWithoutPriorPublication)
    ("Urychlené jednací"@cs :AcceleratedNegotiated)
    ("Vyjednávací se zveřejněním oznámení o zakázce"@cs :NegotiatedWithCompetition)
    ("Vyjednávací bez zveřejnění oznámení o zakázce / výzvy k účasti v soutěži"@cs :NegotiatedWithoutCompetition)
  }
  ?notice pc:procedureType ?_procedureType .
  ?_procedureType skos:prefLabel ?label ;
    ?p ?o .
}
