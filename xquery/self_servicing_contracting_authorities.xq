declare option saxon:output "omit-xml-declaration=yes";
declare option saxon:output "method=text";

for $public-contract in /PrehledZakazekZVestnikuVZ/VerejnaZakazka[ZadavatelICO = DodavatelICO]
  return ($public-contract/CisloFormulareNaVVZ, '&#xa;')
