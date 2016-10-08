PREFIX :     <http://localhost/>
PREFIX csvw: <http://www.w3.org/ns/csvw#>

INSERT {
  ?row :column_1 ?column_1 .
}
WHERE {
  [] csvw:describes ?row ;
    csvw:rownum ?rownum .
  FILTER NOT EXISTS {
    ?row :column_1 [] .
  }
  ?previousRow csvw:rownum ?previousRownum .
  FILTER (?previousRownum < ?rownum)
  FILTER NOT EXISTS {
    [] csvw:rownum ?evenCloserRownum ;
      csvw:describes/:column_1 [] .
    FILTER (?evenCloserRownum > ?previousRownum && ?evenCloserRownum < ?rownum)
  }
  ?previousRow csvw:describes/:column_1 ?column_1 . 
}
