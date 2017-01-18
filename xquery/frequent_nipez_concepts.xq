xquery version "3.0";

declare option saxon:output "omit-xml-declaration=yes";
declare option saxon:output "method=text";

declare variable $items := /PrehledZakazekZETrzist/PolozkyVZ[NIPEZnazevVlastnosti][NIPEZmernaJednotkaVlastnosti];

string-join(
    for $item in $items
    group by $nipezCode := distinct-values($item/NIPEZkod), $nipezName := $item/NIPEZnazev
    let $count := count(distinct-values($item/VZsystemoveCislo))
    order by $count descending
    return (text{string-join(($nipezCode, $nipezName), ",")})
    text{"&#10;"}
)
