declare option saxon:output "omit-xml-declaration=yes";
declare option saxon:output "method=text";

distinct-values(//HodnotaNejnizsiNabidkyMena | //SubdodavkyMena | //PuvodniOdhadovanaCelkovaHodnotaVZMena | //NejnizsiNabidkaVzataVuvahuMena | //OdhadovanaHodnotaVZrozsahMena)
