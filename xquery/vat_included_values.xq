declare option saxon:output "omit-xml-declaration=yes";
declare option saxon:output "method=text";

distinct-values(//PuvodniOdhadovanaCelkovaHodnotaVZprocentniSazbaDPH | //HodnotaNejnizsiNabidkySazbaDPH | //CelkovaKonecnaHodnotaVZprocentniSazbaDPHzaZadani | //CelkovaKonecnaHodnotaVZprocentniSazbaDPH | //NejnizsiNabidkaVzataVuvahuProcentniSazbaDPH)
