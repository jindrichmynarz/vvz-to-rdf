PREFIX adms:   <http://www.w3.org/ns/adms#>
PREFIX rov:    <http://www.w3.org/ns/regorg#>
PREFIX schema: <http://schema.org/>
PREFIX skos:   <http://www.w3.org/2004/02/skos/core#>

DELETE {
  ?_organization ?outP ?outO .
  ?inS ?inP ?_organization .
}
INSERT {
  ?organization ?outP ?outO .
  ?inS ?inP ?organization .
  ?organization rov:registration ?registration .
  ?registration a adms:Identifier ;
    skos:notation ?ico ;
    skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/CZ-ICO> .
}
WHERE {
  {
    SELECT ?_organization ?organization ?ico ?registration
    WHERE {
      VALUES (?domain ?ico) {
        ("agrostav-pce.cz" "46506063")
        ("alta.cz" "28317556")
        ("amimedical.cz" "63983524")
        ("area.cz" "25094459")
        ("artspect.cz" "28123395")
        ("autocont.cz" "47676795")
        ("beckman.cz" "28233492")
        ("biopro.cz" "62914511")
        ("biotech.cz" "25664018")
        ("centraldepository.cz" "25081489")
        ("centropolenergy.cz" "25458302")
        ("csystem.cz" "26249979")
        ("dpova.cz" "42767377")
        ("drevo-malek.cz" "25509420")
        ("ekoplan.cz" "64576574")
        ("elgas.cz" "47469978")
        ("eon.cz" "25733591")
        ("eopru.cz" "25040707")
        ("epet.cz" "28356250")
        ("eppendorf.cz" "64254577")
        ("eurovia.cz" "61250210")
        ("geodeziehcm.cz" "47543621")
        ("gepard.cz" "61499552")
        ("gteam.cz" "48360171")
        ("hmpro.cz" "24801224")
        ("igea.cz" "26276038")
        ("inexcz.cz" "61328987")
        ("inova.cz" "64940586")
        ("instruments.cz" "25065939")
        ("kdz.cz" "15526691")
        ("klobouckalesni.cz" "25532642")
        ("krd.cz" "26424991")
        ("lescus.cz" "60732547")
        ("lesostavby.cz" "45193118")
        ("linet.cz" "00507814")
        ("luvil.cz" "47057114")
        ("mariuspedersen.cz" "42194920")
        ("marsjev.cz" "48152366")
        ("mediprax.cz" "63886731")
        ("medsol.cz" "24201596")
        ("meliorace.cz" "47905913")
        ("merci.cz" "46966447")
        ("mikro.cz" "41604326")
        ("neumannstav.cz" "28177851")
        ("nicoletcz.cz" "26422182")
        ("nikon.cz" "61509426")
        ("noen.cz" "25601598")
        ("olympus.cz" "27068641")
        ("parole.cz" "27285359")
        ("pohl.cz" "25606468")
        ("ppas.cz" "60193492")
        ("prodeco.cz" "25020790")
        ("promedica-praha.cz" "25099019")
        ("prvnichranenadilna.cz" "28685521")
        ("psvplzen.cz" "25225898")
        ("radixcz.cz" "26774321")
        ("rmi.cz" "25288083")
        ("roche.cz" "49617052")
        ("skanska.cz" "26271303")
        ("sntplus.cz" "25701576")
        ("solitera.cz" "43762751")
        ("spektravision.cz" "24769118")
        ("strabag.cz" "60838744")
        ("sumavskezahrady.cz" "29112958")
        ("swietelsky.cz" "48035599")
        ("tatra.cz" "01482840")
        ("thermofisher.cz" "45539928")
        ("trigon-plus.cz" "46350110")
        ("workswell.cz" "29048575")
        ("wwwklobouckalesni.cz" "25532642")
        ("ys.cz" "00174939")
      }
      ?_organization a schema:Organization ;
        schema:url ?url .
      FILTER NOT EXISTS {
        ?_organization rov:registration/skos:inScheme <http://linked.opendata.cz/resource/concept-scheme/CZ-ICO> .
      }
      FILTER CONTAINS(?url, ".cz")
      BIND (REPLACE(?url, "^[a-z]+:\\/\\/(www\\.)?([^/]+).*$", "$2") AS ?domain)
      BIND (IRI(CONCAT("http://linked.opendata.cz/resource/business-entity/CZ", ?ico)) AS ?organization)
      BIND (IRI(CONCAT("http://linked.opendata.cz/resource/isvz.cz/identifier/", ?ico)) AS ?registration)
    }
  }
  ?_organization ?outP ?outO .
  OPTIONAL {
    ?inS ?inP ?_organization .
  }
}
