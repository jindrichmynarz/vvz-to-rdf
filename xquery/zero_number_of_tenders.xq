declare option saxon:output "omit-xml-declaration=yes";
declare option saxon:output "method=text";

for $lot in /PrehledZakazekZVestnikuVZ/CastiVerejneZakazky[PocetObdrzenychNabidek = "0"
                                                           and
                                                           PlatnyFormular = "true"]
  return ($lot/EvidencniCisloVZnaVVZ, '-', $lot/CisloCastiZadaniVZ, '&#xa;')
