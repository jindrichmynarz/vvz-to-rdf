declare option saxon:output "omit-xml-declaration=yes";
declare option saxon:output "method=text";

distinct-values(/PrehledZakazekZVestnikuVZ/CastiVerejneZakazky/DatumZadaniVZ/substring(text(), 7, 4))
