PREFIX : <http://schema.org/>

DELETE {
  ?organization :url ?httpUrl .
}
WHERE {
  ?organization :url ?httpsUrl, ?httpUrl .
  FILTER (strstarts(?httpsUrl, "https://")
          &&
          strstarts(?httpUrl, "http://")
          &&
          strafter(?httpsUrl, "https://") = strafter(?httpUrl, "http://"))
}
