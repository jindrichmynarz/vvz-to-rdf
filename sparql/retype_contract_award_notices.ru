PREFIX pc:    <http://purl.org/procurement/public-contracts#>
PREFIX pproc: <http://contsem.unizar.es/def/sector-publico/pproc#>

DELETE {
  ?notice a pproc:Notice .
}
INSERT {
  ?notice a pproc:ContractAwardNotice .
}
WHERE {
  ?notice a pproc:Notice ;
    pc:awardedTender [] .
}
