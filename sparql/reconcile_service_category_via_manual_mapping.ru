PREFIX :       <http://linked.opendata.cz/resource/concept-scheme/eur-lex.europa.eu/service-categories/concept/>
PREFIX isvz:   <http://linked.opendata.cz/ontology/isvz.cz/>
PREFIX scheme: <http://linked.opendata.cz/resource/concept-scheme/eur-lex.europa.eu/service-categories>
PREFIX skos:   <http://www.w3.org/2004/02/skos/core#>

WITH <http://linked.opendata.cz/resource/dataset/isvz.cz>
DELETE {
  ?_serviceCategory ?outP ?outO .
  ?inS ?inP ?_serviceCategory .
}
INSERT {
  ?inS ?inP ?serviceCategory .
}
WHERE {
  {
    SELECT ?_serviceCategory ?label ?serviceCategory
    WHERE {
      {
        SELECT DISTINCT ?_serviceCategory ?label
        WHERE {
          [] isvz:serviceCategory ?_serviceCategory .
          ?_serviceCategory skos:prefLabel ?label .
        }
      }
      VALUES (?label ?serviceCategory) {
             ("Pozemní přeprava, včetně přepravy peněz a kurýrních služeb, s vyjímkou přepravy pošty"@cs :2)
             ("Letecká přeprava cestujících i nákladu, s vyjímkou pošty"@cs :3)
             ("Finanční služby"@cs :6)
             ("Pojišťovací služby"@cs :6)
             ("Bankovní a investiční služby"@cs :6)
             ("Počítačové zpracovaní dat a s tím spojené služby"@cs :7)
             ("Účetnictví a audit"@cs :9)
             ("Služby architektů; inženýrské služby, integrované inženýrské služby, územní plánování; související vědeckotechnické poradenství; technické testování a"@cs :12)
             ("Služby týkající se kanalizací a odvozu odpadu; sanitární a podobné služby"@cs :16)
             ("Úklidové služby a domovní správa"@cs :14)
             ("Vydavatelské a tiskařské služby za úplatu nebo na smluvním základě"@cs :15)
             ("Pohostinství a ubytovací služby"@cs :17)
             ("Železnice"@cs :18)
             ("Personální agentury"@cs :22)
             ("Pátrací a bezpečnostní služby, s výjimkou přepravy peněz"@cs :23)
             ("Vzdělávání a odborné vzdělávání"@cs :24)
             ("Zdravotnictví a sociální služby"@cs :25)
             ("Rekreace, kultura a sport"@cs :26)
      }
    }
  }
  ?_serviceCategory ?outP ?outO .
  ?inS ?inP ?_serviceCategory .
}
