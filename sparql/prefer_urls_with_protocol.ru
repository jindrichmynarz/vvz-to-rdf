PREFIX : <http://schema.org/>

DELETE {
  ?organization :url ?urlWithoutProtocol .
}
WHERE {
  ?organization :url ?urlWithProtocol, ?urlWithoutProtocol .
  FILTER (!sameTerm(?urlWithProtocol, ?urlWithoutProtocol)
          &&
          STRENDS(?urlWithProtocol, ?urlWithoutProtocol)
          &&
          REGEX(?urlWithProtocol, "^[^:]+://"))
}
