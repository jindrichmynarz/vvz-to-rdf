<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
    <!ENTITY pc      "http://purl.org/procurement/public-contracts#">
    <!ENTITY pccz    "http://purl.org/procurement/public-contracts-czech#">
    <!ENTITY pcdt    "http://purl.org/procurement/public-contracts-datatypes#">
    <!ENTITY pproc   "http://contsem.unizar.es/def/sector-publico/pproc#">
    <!ENTITY xsd     "http://www.w3.org/2001/XMLSchema#">
]>
<xsl:stylesheet
    xmlns:adms="http://www.w3.org/ns/adms#"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:f="http://opendata.cz/xslt/functions#"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:gr="http://purl.org/goodrelations/v1#"
    xmlns:pc="http://purl.org/procurement/public-contracts#"
    xmlns:pccz="http://purl.org/procurement/public-contracts-czech#"
    xmlns:pproc="http://contsem.unizar.es/def/sector-publico/pproc#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rov="http://www.w3.org/ns/regorg#"
    xmlns:schema="http://schema.org/"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="f xsd"
    version="2.0">
    
    <!-- Global variables -->
    
    <xsl:variable name="ns">http://linked.opendata.cz/resource/isvz.cz/</xsl:variable>
    <xsl:variable name="cpv2008Ns">http://linked.opendata.cz/resource/cpv-2008/concept/</xsl:variable>
    <xsl:variable name="cpv2003Ns">http://linked.opendata.cz/resource/cpv-2003/concept/</xsl:variable>
    
    <!-- Functions -->
    
    <!-- Clears a CPV code -->
    <xsl:function name="f:clearCpv" as="xsd:string">
        <xsl:param name="cpv" as="xsd:string"/>
        <xsl:value-of select="f:removeCheckDigit(f:removeWhitespace($cpv))"/>
    </xsl:function>
    
    <!-- Mints a new URI in namespace $ns for instance of $class identified with $key. -->
    <xsl:function name="f:getInstanceUri" as="xsd:anyURI">
        <xsl:param name="class" as="xsd:string"/>
        <xsl:param name="key" as="xsd:string"/>
        <xsl:value-of select="concat($ns, f:kebabCase($class), '/', f:slugify($key))"/>
    </xsl:function>
    
    <!-- Tests if date is valid xsd:date. -->
    <xsl:function name="f:isValidDate" as="xsd:boolean">
        <xsl:param name="date" as="xsd:string"/>
        <xsl:value-of select="$date castable as xsd:date"/>
    </xsl:function>
    
    <!-- Converts camelCase $text into kebab-case. -->
    <xsl:function name="f:kebabCase" as="xsd:string">
        <xsl:param name="text" as="xsd:string"/>
        <xsl:value-of select="f:slugify(replace($text, '(\p{Ll})(\p{Lu})', '$1-$2'))"/>
    </xsl:function>
    
    <!-- Removes check digit from CPV code -->
    <xsl:function name="f:removeCheckDigit">
        <xsl:param name="code"/>
        <xsl:value-of select="tokenize($code, '-')[1]"/>
    </xsl:function>
    
    <!-- Removes whitespace -->
    <xsl:function name="f:removeWhitespace" as="xsd:string">
        <xsl:param name="text" as="xsd:string"/>
        <xsl:value-of select="replace($text, '\s', '')"/>
    </xsl:function>
    
    <!-- Converts $text into URI-safe slug. -->
    <xsl:function name="f:slugify" as="xsd:anyURI">
        <xsl:param name="text" as="xsd:string"/>
        <xsl:value-of select="encode-for-uri(translate(replace(lower-case(normalize-unicode($text, 'NFKD')), '\P{IsBasicLatin}', ''), ' ', '-'))" />
    </xsl:function>
    
    <!-- Transforms dd.mm.yyyy date to yyyy-mm-dd date. -->
    <xsl:function name="f:transformDate">
        <xsl:param name="date" as="xsd:string"/>
        <xsl:analyze-string select="$date" regex="(\d{{2}})\.(\d{{2}})\.(\d{{4}})">
            <xsl:matching-substring>
                <xsl:value-of select="concat(regex-group(3), '-', regex-group(2), '-', regex-group(1))"/>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:function>
    
    <!-- Trims leading and trailing whitespace -->
    <xsl:function name="f:trim" as="xsd:string">
        <xsl:param name="text" as="xsd:string"/>
        <xsl:value-of select="replace($text, '^\s+|\s+$', '')"/>
    </xsl:function>
    
    <!-- Tests if IČO is valid.
    The MIT License (MIT)
    
    Copyright (c) 2013 Jiří Skuhrovec, Martin Nečaský
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
    -->
    <xsl:function name="f:isValidIco" as="xsd:boolean">
        <xsl:param name="ico" as="xsd:string"/>
        
        <xsl:choose>
            <xsl:when test="string-length($ico) = 0">
                <xsl:value-of select="false()" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:analyze-string select="$ico" regex="^([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])$">		
                    <xsl:matching-substring>
                        <xsl:variable name="n8" select="number(regex-group(1))" />
                        <xsl:variable name="n7" select="number(regex-group(2))" />
                        <xsl:variable name="n6" select="number(regex-group(3))" />
                        <xsl:variable name="n5" select="number(regex-group(4))" />
                        <xsl:variable name="n4" select="number(regex-group(5))" />
                        <xsl:variable name="n3" select="number(regex-group(6))" />
                        <xsl:variable name="n2" select="number(regex-group(7))" />
                        <xsl:variable name="checkNumber" select="number(regex-group(8))" />
                        
                        <xsl:variable name="checkSum" select="$n8*8 + $n7*7 + $n6*6 + $n5*5 + $n4*4 + $n3*3 + $n2*2" />
                        
                        <xsl:variable name="checkSumMod" select="(11 - ($checkSum mod 11)) mod 10" />
                        
                        <xsl:choose>
                            <xsl:when test="$checkNumber = $checkSumMod">
                                <xsl:value-of select="true()" />
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="false()" />
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <xsl:value-of select="false()" />
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- Output -->
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml" normalization-form="NFC" />
    <xsl:strip-space elements="*"/>
    
    <xsl:key name="contracts" match="/PrehledZakazekZVestnikuVZ/VerejnaZakazka" use="EvidencniCisloVZnaVVZ/text()"/>
    
    <!-- Templates -->
    
    <xsl:template match="/PrehledZakazekZVestnikuVZ">
        <rdf:RDF>
            <xsl:apply-templates/>
        </rdf:RDF>
    </xsl:template>
    
    <xsl:template match="CastiVerejneZakazky">
        <pproc:Lot>
            <xsl:variable name="partId" select="if (CisloCastiZadaniVZ) then CisloCastiZadaniVZ/text() else generate-id()"/>
            <xsl:variable name="lotId" select="if (CisloFormulareNaVVZ) then CisloFormulareNaVVZ/text() else EvidencniCisloVZnaVVZ/text()"/>
            <xsl:attribute name="rdf:about" select="f:getInstanceUri('Lot', concat($lotId, '-', $partId, '-', generate-id()))"/>
            
            <!-- Evid. číslo na VVZ -->
            <pc:isLotOf rdf:resource="{f:getInstanceUri('Contract', EvidencniCisloVZnaVVZ/text())}"/>
            
            <xsl:apply-templates mode="lot"/>
            <xsl:if test="DodavatelNazev">
                <pc:awardedTender>
                    <pc:Tender>
                        <pc:bidder>
                            <schema:Organization>
                                <xsl:variable name="icos" select="key('contracts', EvidencniCisloVZnaVVZ/text())/DodavatelICO/text()"/>
                                <xsl:if test="not(empty($icos))">
                                    <xsl:variable name="ico" select="$icos[1]"/>
                                    <xsl:if test="f:isValidIco($ico)">
                                        <xsl:attribute name="rdf:about" select="concat('http://linked.opendata.cz/resource/business-entity/CZ', $ico)"/>
                                    </xsl:if>
                                    <xsl:call-template name="ico">
                                        <xsl:with-param name="ico" select="$ico"/>
                                    </xsl:call-template>
                                </xsl:if>
                                
                                <xsl:apply-templates mode="supplier"/>
                                
                                <xsl:if test="DodavatelPostovniAdresa">
                                    <schema:address>
                                        <schema:PostalAddress>
                                            <xsl:apply-templates mode="supplier-address"/>
                                        </schema:PostalAddress>
                                    </schema:address>
                                </xsl:if>
                            </schema:Organization>
                        </pc:bidder>
                    </pc:Tender>
                </pc:awardedTender>
            </xsl:if>
        </pproc:Lot>
    </xsl:template>
    
    <xsl:template match="EvidencniCisloVZnaVVZ" mode="lot">
        <!-- Evid. číslo na VVZ -->
        <adms:identifier>
            <adms:Identifier rdf:about="{f:getInstanceUri('Identifier', text())}">
                <skos:notation><xsl:value-of select="text()"/></skos:notation>
                <skos:inScheme rdf:resource="{f:getInstanceUri('ConceptScheme', 'evidencni-cisla-vz-na-vvz')}"/>
            </adms:Identifier>
        </adms:identifier>
    </xsl:template>

    <xsl:template match="CisloFormulareNaVVZ" mode="lot">
        <!-- Evidenční číslo formuláře -->
        <adms:identifier>
            <adms:Identifier rdf:about="{f:getInstanceUri('Identifier', text())}">
                <skos:notation><xsl:value-of select="text()"/></skos:notation>
                <skos:inScheme rdf:resource="{f:getInstanceUri('ConceptScheme', 'cisla-formulare-na-vvz')}"/>
            </adms:Identifier>
        </adms:identifier>
    </xsl:template>
    
    <xsl:template match="CisloCastiZadaniVZ" mode="lot">
        <!-- Č. části oddílu zadání zakázky -->
        <adms:identifier>
            <adms:Identifier rdf:about="{f:getInstanceUri('Identifier', text())}">
                <skos:notation><xsl:value-of select="text()"/></skos:notation>
                <skos:inScheme rdf:resource="{f:getInstanceUri('ConceptScheme', 'cisla-casti-zadani-vz')}"/>
            </adms:Identifier>
        </adms:identifier>
    </xsl:template>
    
    <xsl:template match="NazevCastiVZ" mode="lot">
        <dcterms:title xml:lang="cs"><xsl:value-of select="normalize-space(text())"/></dcterms:title>
    </xsl:template>
   
    <xsl:template match="DatumZadaniVZ" mode="lot">
        <xsl:call-template name="dateProperty">
            <xsl:with-param name="property">pc:awardDate</xsl:with-param>
        </xsl:call-template>    
    </xsl:template>
    
    <xsl:template match="PocetObdrzenychNabidek" mode="lot">
        <pc:numberOfTenders rdf:datatype="&xsd;nonNegativeInteger"><xsl:value-of select="text()"/></pc:numberOfTenders>    
    </xsl:template>
    
    <xsl:template match="DodavatelNazev" mode="supplier">
        <!-- Název dodavatele, kterému byla zakázka zadána -->
        <schema:legalName><xsl:value-of select="normalize-space(text())"/></schema:legalName>
    </xsl:template>
    
    <xsl:template match="DodavatelPostovniAdresa" mode="supplier-address">
        <!-- Poštovní adresa dodavatele, kterému byla zakázka zadána. -->
        <schema:streetAddress><xsl:value-of select="normalize-space(text())"/></schema:streetAddress>
    </xsl:template>
    
    <xsl:template match="DodavatelObec" mode="supplier-address">
        <!-- pc:awardedTender/pc:bidder/schema:address -->
        <schema:addressLocality><xsl:value-of select="normalize-space(text())"/></schema:addressLocality>
    </xsl:template>
    
    <xsl:template match="DodavatelPSC" mode="supplier-address">
        <!-- pc:awardedTender/pc:bidder/schema:address -->
        <schema:postalCode><xsl:value-of select="f:removeWhitespace(text())"/></schema:postalCode>
    </xsl:template>
    
    <xsl:template match="DodavatelStat" mode="supplier-address">
        <!-- pc:awardedTender/pc:bidder/schema:address -->
        <schema:addressCountry><xsl:value-of select="text()"/></schema:addressCountry>
    </xsl:template>
    
    <xsl:template match="DodavatelWww" mode="supplier">
        <!-- Internetová adresa (URL) dodavatele, kterému byla zakázka zadána. -->
        <schema:url><xsl:value-of select="text()"/></schema:url>
    </xsl:template>
    
    <xsl:template match="HodnotaNejnizsiNabidky" mode="lot">
        <!-- Hodnota nejnižší nabídky -->
        <pc:lowestBidPrice>
            <schema:PriceSpecification>
                <xsl:call-template name="price"/>
                <xsl:apply-templates select="../*" mode="lowest-price"/>
            </schema:PriceSpecification>
        </pc:lowestBidPrice>
    </xsl:template>
    
    <xsl:template match="HodnotaNejnizsiNabidkySazbaDPH" mode="lowest-price">
        <!-- Hodnota nejnižší nabídky - Sazba DPH -->
        <xsl:call-template name="valueAddedTax"/>
    </xsl:template>
    
    <xsl:template match="HodnotaNejnizsiNabidkyProcentniSazbaDPH" mode="lowest-price">
        <!-- Hodnota nejnižší nabídky - % -->
        <xsl:call-template name="valueAddedTaxRate"/>
    </xsl:template>
    
    <xsl:template match="HodnotaNejnizsiNabidkyMena" mode="lowest-price">
        <!-- Hodnota nejnižší nabídky - Měna -->
        <xsl:call-template name="priceCurrency"/>
    </xsl:template>
    
    <xsl:template match="OdhadovanaHodnotaVZbezDPH" mode="contract">
        <!-- Předpokládaná hodnota VZ s využitím pravidel uvedených v § 13 ZVZ a u VZ na dodávky podle § 14 ZVZ,
             VZ na služby podle § 15 ZVZ nebo VZ na stavební práce podle § 16 ZVZ. Částka se uvádí bez DPH. -->
        <pc:estimatedPrice>
            <schema:PriceSpecification>
                <xsl:call-template name="price"/>
                <schema:valueAddedTaxIncluded rdf:datatype="&xsd;boolean"><xsl:value-of select="false()"/></schema:valueAddedTaxIncluded>
                <xsl:apply-templates select="../*" mode="estimated-price"/>
            </schema:PriceSpecification>
        </pc:estimatedPrice>
    </xsl:template>
    
    <xsl:template match="OdhadovanaHodnotaVZmena" mode="estimated-price">
        <!-- Měna předpokládané hodnoty VZ -->
        <xsl:call-template name="priceCurrency"/>
    </xsl:template>
    
    <xsl:template match="PuvodniOdhadovanaCelkovaHodnotaVZ" mode="lot">
        <!-- Původní odhadovaná celková hodnota části zakázky. -->
        <pc:estimatedTotalPrice>
            <schema:PriceSpecification>
                <xsl:call-template name="price"/>
                <xsl:apply-templates select="../*" mode="estimated-total-price"/>
            </schema:PriceSpecification>
        </pc:estimatedTotalPrice>
    </xsl:template>
    
    <xsl:template match="PuvodniOdhadovanaCelkovaHodnotaVZMena" mode="estimated-total-price">
        <!-- Původní odhadovaná celková hodnota části zakázky – Měna. -->
        <xsl:call-template name="priceCurrency"/>
    </xsl:template>
    
    <xsl:template match="PuvodniOdhadovanaCelkovaHodnotaVZsazbaDPH" mode="estimated-total-price">
        <!-- Původní odhadovaná celková hodnota části zakázky - Sazba DPH -->
        <xsl:call-template name="valueAddedTax"/>
    </xsl:template>
    
    <xsl:template match="PuvodniOdhadovanaCelkovaHodnotaVZprocentniSazbaDPH" mode="estimated-total-price">
        <!-- Původní odhadovaná celková hodnota části zakázky - % -->
        <xsl:call-template name="valueAddedTaxRate"/>
    </xsl:template>
    
    <xsl:template match="OdhadovanaHodnotaVZrozsahOd" mode="contract">
        <!-- Dolní mez předpokládané hodnoty veřejné zakázky bez DPH. Uvádí se pro VZ, kde je cena uvedena rozsahem. -->
        <pc:estimatedPrice>
            <schema:PriceSpecification>
                <schema:minPrice rdf:datatype="&xsd;decimal"><xsl:value-of select="text()"/></schema:minPrice>
                <xsl:apply-templates select="../*" mode="estimated-price-range"/>
            </schema:PriceSpecification>
        </pc:estimatedPrice>
    </xsl:template>
    
    <xsl:template match="OdhadovanaHodnotaVZrozsahDo" mode="estimated-price-range">
        <!-- Horní mez předpokládané hodnoty veřejné zakázky bez DPH. Uvádí se pro VZ, kde je cena uvedena rozsahem -->
        <schema:maxPrice rdf:datatype="&xsd;decimal"><xsl:value-of select="text()"/></schema:maxPrice>
    </xsl:template>
    
    <xsl:template match="OdhadovanaHodnotaVZrozsahMena" mode="estimated-price-range">
        <!-- Měna předpokládané hodnoty VZ uváděné rozsahem. -->
        <xsl:call-template name="priceCurrency"/>
    </xsl:template>
    
    <xsl:template match="CelkovaKonecnaHodnotaVZzaZadani" mode="lot">
        <!-- Celková konečná hodnota části zakázky -->
        <pc:actualPrice>
            <schema:PriceSpecification>
                <xsl:call-template name="price"/>
                <xsl:apply-templates select="../*" mode="actual-price"/>
            </schema:PriceSpecification>
        </pc:actualPrice>
    </xsl:template>
    
    <xsl:template match="CelkovaKonecnaHodnotaVZmenaZaZadani" mode="actual-price">
        <!-- Celková konečná hodnota části zakázky – Měna -->
        <xsl:call-template name="priceCurrency"/>
    </xsl:template>
    
    <xsl:template match="CelkovaKonecnaHodnotaVZSazbaDPHzaZadani" mode="actual-price">
        <!-- Celková konečná hodnota části zakázky - Sazba DPH -->
        <xsl:call-template name="valueAddedTax"/>
    </xsl:template>
    
    <xsl:template match="CelkovaKonecnaHodnotaVZprocentniSazbaDPHzaZadani" mode="actual-price">
        <!-- Celková konečná části hodnota zakázky - % -->
        <xsl:call-template name="valueAddedTaxRate"/>
    </xsl:template>
    
    <xsl:template match="CelkovaKonecnaHodnotaVZ" mode="contract">
        <!-- Celková konečná hodnota VZ, včetně všech zakázek, částí zakázek, obnovení a opcí. -->
        <pc:actualPrice>
            <schema:PriceSpecification>
                <xsl:call-template name="price"/>
                <xsl:apply-templates select="../*" mode="actual-price"/>
            </schema:PriceSpecification>
        </pc:actualPrice>
    </xsl:template>
    
    <xsl:template match="CelkovaKonecnaHodnotaVZmena" mode="actual-price">
        <!-- Celková konečná hodnota VZ - Měna -->
        <xsl:call-template name="priceCurrency"/>
    </xsl:template>
    
    <xsl:template match="CelkovaKonecnaHodnotaVZsazbaDPH" mode="actual-price">
        <!-- Celková konečná hodnota VZ - Sazba DPH -->
        <xsl:call-template name="valueAddedTax"/>
    </xsl:template>
    
    <xsl:template match="CelkovaKonecnaHodnotaVZprocentniSazbaDPH" mode="actual-price">
        <!-- Celková konečná hodnota zakázky či zakázek - (%) -->
        <xsl:call-template name="valueAddedTaxRate"/>
    </xsl:template>
    
    <xsl:template match="SubdodavkyHodnotaBezDPH" mode="lot">
        <!-- Hodnota zakázky, která bude provedena subdodavatelsky třetími stranami - Hodnota bez DPH -->
        <pc:subcontractingPrice>
            <schema:PriceSpecification>
                <xsl:call-template name="price"/>
                <schema:valueAddedTaxIncluded rdf:datatype="&xsd;boolean"><xsl:value-of select="false()"/></schema:valueAddedTaxIncluded>
                <xsl:apply-templates select="../*" mode="subcontracting-price"/>
            </schema:PriceSpecification>
        </pc:subcontractingPrice>
    </xsl:template>
    
    <xsl:template match="SubdodavkyMena" mode="subcontracting-price">
        <!-- Hodnota zakázky, která bude provedena subdodavatelsky třetími stranami - Měna -->
        <xsl:call-template name="priceCurrency"/>
    </xsl:template>
    
    <xsl:template match="SubdodavkyPomer" mode="lot">
        <!-- Hodnota zakázky, která bude provedena subdodavatelsky třetími stranami - Poměr -->
        <pc:subcontractingRatio rdf:datatype="&pcdt;percentage"><xsl:value-of select="text()"/></pc:subcontractingRatio>
    </xsl:template>
    
    <xsl:template match="RocniCiMesicniHodnotaPocetRoku" mode="lot">
        <!-- Roční či měsíční hodnota - počet roků -->
        <pc:duration rdf:datatype="&xsd;duration"><xsl:value-of select="concat('P', text(), 'Y')"/></pc:duration>
    </xsl:template>
    
    <xsl:template match="RocniCiMesicniHodnotaPocetMesicu" mode="lot">
        <!-- Roční či měsíční hodnota - počet měsíců -->
        <pc:duration rdf:datatype="&xsd;duration"><xsl:value-of select="concat('P', text(), 'M')"/></pc:duration>
    </xsl:template>
    
    <xsl:template match="VerejnaZakazka">
        <!-- Documentation: http://www.portal-vz.cz/cs/Informacni-systemy-a-elektronicke-vzdelavani/Information-System-on-Public-Contracts/Uverejnovaci-subsystem/Zmena-v-klasifikaci-CPV-kodu-pro-verejne-zakaz -->
        <xsl:variable name="cpvSchemeYear">
            <xsl:choose>
                <xsl:when test="xsd:date(f:transformDate(DatumOdeslaniFormulareNaVVZ/text())) le xsd:date('2008-09-12')">2003</xsl:when>
                <xsl:otherwise>2008</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <pc:Contract rdf:about="{f:getInstanceUri('Contract', EvidencniCisloVZnaVVZ/text())}">
            <xsl:apply-templates mode="contract">
                <xsl:with-param name="cpvSchemeYear" select="$cpvSchemeYear" tunnel="yes"/>
            </xsl:apply-templates>
            <xsl:if test="ZadavatelUredniNazev">
                <pc:contractingAuthority>
                    <schema:Organization>
                        <xsl:apply-templates mode="contracting-authority"/>
                    </schema:Organization>
                </pc:contractingAuthority>
            </xsl:if>
            <xsl:if test="*[starts-with(name(), 'Kriterium')]">
                <pc:awardCriteriaCombination>
                    <pc:AwardCriteriaCombination>
                        <xsl:apply-templates mode="award-criteria-combination"/>
                    </pc:AwardCriteriaCombination>
                </pc:awardCriteriaCombination>
            </xsl:if>
        </pc:Contract>
    </xsl:template>
    
    <xsl:template match="DruhFormulare" mode="lot">
        <!-- Druh formuláře (řádný/opravný) -->
        <xsl:choose>
            <xsl:when test="text() = 'Opravný'">
                <rdf:type rdf:resource="&pproc;CorrectionNotice"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="TypFormulare" mode="lot">
        <!-- Type formuláře (F01, F02, F03…F55) -->
        <dcterms:type>
            <skos:Concept rdf:about="{f:getInstanceUri('Concept', concat('form-type-', text()))}">
                <skos:notation><xsl:value-of select="text()"/></skos:notation>
                <skos:inScheme rdf:resource="{f:getInstanceUri('ConceptScheme', 'form-types')}"/>
            </skos:Concept>
        </dcterms:type>
    </xsl:template>
    
    <xsl:template match="VZdelenaNaCasti" mode="contract">
        <!-- VZ dělená na části. Vyplňováno pouze v případě, že
             pro VZ existuje výsledkový formulář (počítáno podle
             počtu zadání ve výsledkovém formuláři). -->
        <rdf:type>
            <xsl:attribute name="rdf:resource">
                <xsl:choose>
                    <xsl:when test="text() = 'Ano'">&pproc;ContractWithLots</xsl:when>
                    <xsl:when test="text() = 'Ne'">&pproc;ContractWithoutLots</xsl:when>
                </xsl:choose>
            </xsl:attribute>
        </rdf:type>
    </xsl:template>
    
    <xsl:template match="ZadavatelICO" mode="contracting-authority">
        <!-- IČO zadavatele -->
        <xsl:call-template name="ico">
            <xsl:with-param name="ico" select="text()"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="LimitVZ" mode="contract">
        <!-- Limit VZ (nadlimitní/podlimitní) -->
        <pccz:limit>
            <xsl:attribute name="rdf:resource">
                <xsl:choose>
                    <xsl:when test="text() = 'nadlimitní'">&pccz;AboveLimit</xsl:when>
                    <xsl:when test="text() = 'podlimitní'">&pccz;UnderLimit</xsl:when>
                </xsl:choose>
            </xsl:attribute>
        </pccz:limit>
    </xsl:template>
    
    <xsl:template match="DatumOdeslaniFormulareNaVVZ" mode="contract">
        <!-- Datum odeslání formuláře provozovateli Věstníku VZ k uveřejnění. -->
        <xsl:call-template name="dateProperty">
            <xsl:with-param name="property">dcterms:dateSubmitted</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="DatumUverejneni" mode="contract">
        <!-- Datum zveřejnění na Věstníku VZ -->
        <xsl:call-template name="dateProperty">
            <xsl:with-param name="property">dcterms:issued</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="ZadavatelUredniNazev" mode="contracting-authority">
        <!-- Úřední název zadavatele. U obchodních společností položka obsahuje název obchodní firmy
             zapsané v obchodním rejstříku, u fyzických osob obsahuje jméno a příjmení fyzické osoby. -->
        <schema:legalName><xsl:value-of select="normalize-space(text())"/></schema:legalName>
    </xsl:template>
    
    <xsl:template match="ZadavatelDruh" mode="contracting-authority">
        <!-- Druh veřejného zadavatele. Položka nabývá jednu ze 7 nabízených možností podle § 2 ZVZ. -->
        <pc:authorityKind>
            <skos:Concept>
                <skos:prefLabel xml:lang="cs"><xsl:value-of select="normalize-space(text())"/></skos:prefLabel>
            </skos:Concept>
        </pc:authorityKind>
    </xsl:template>
    
    <xsl:template match="ZadavatelHlavniPredmetCinnosti" mode="contracting-authority">
        <!-- Hlavní předmět činnosti veřejného zadavatele, který nejlépe odpovídá oblasti působnosti veřejného zadavatele.
             Položka nabývá jednu z 11 hodnot. -->
        <xsl:for-each select="tokenize(text(), ';')">
            <pc:mainActivity>
                <skos:Concept>
                    <skos:prefLabel xml:lang="cs"><xsl:value-of select="f:trim(.)"/></skos:prefLabel>
                </skos:Concept>
            </pc:mainActivity>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="ZadavatelZadavaJmenemJinych" mode="contract">
        <!-- Veřejný zadavatel zadává veřejnou zakázku pro jiné zadavatele (veřejné nebo sektorové)
             např. na základě uzavření smlouvy o centralizovaném zadávání nebo jiné obdobné smlouvy. -->
        <xsl:if test="text() = 'Ano'">
            <pc:isOnBehalfOf rdf:datatype="&xsd;boolean"><xsl:value-of select="true()"/></pc:isOnBehalfOf>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="NazevVZ" mode="contract">
        <!-- Název přidělený veřejné zakázce -->
        <dcterms:title xml:lang="cs"><xsl:value-of select="normalize-space(text())"/></dcterms:title>
    </xsl:template>
    
    <xsl:template match="DruhVZ" mode="contract">
        <!-- Druh zakázky (dodávky, služby, stavební práce) -->
        <pc:kind>
            <skos:Concept>
                <skos:prefLabel xml:lang="cs"><xsl:value-of select="normalize-space(text())"/></skos:prefLabel>
            </skos:Concept>
        </pc:kind>
    </xsl:template>
    
    <xsl:template match="KategorieSluzeb" mode="contract">
        <!-- Číslo kategorie služby podle přílohy II směrnice č. 2004/18/ES. -->
        <xsl:for-each select="tokenize(text(), ';')">
            <pc:serviceCategory>
                <skos:Concept>
                    <skos:prefLabel xml:lang="cs"><xsl:value-of select="f:trim(.)"/></skos:prefLabel>
                </skos:Concept>
            </pc:serviceCategory>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="HlavniMistoPlneni" mode="contract">
        <!-- NUTS 3 hlavního místo plnění VZ. Při plnění veřejné zakázky mimo území EU se uvádí NUTS kód CZZZZ (Extra-Regio). -->
        <pc:location>
            <schema:Place>
                <schema:address>
                    <schema:PostalAddress>
                        <xsl:variable name="text" select="normalize-space(text())"/>
                        <xsl:analyze-string select="$text" regex="^.*(\d{{3}}\s*\d{{2}}).*$">
                            <xsl:matching-substring>
                                <schema:postalCode><xsl:value-of select="replace(regex-group(1), '\s+', '')"/></schema:postalCode>
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                        <schema:description><xsl:value-of select="$text"/></schema:description>
                    </schema:PostalAddress>
                </schema:address>
            </schema:Place>
        </pc:location>
    </xsl:template>
    
    <xsl:template match="StrucnyPopisVZ" mode="contract">
        <!-- Textový popis charakteristiky předmětu veřejné zakázky. -->
        <dcterms:description xml:lang="cs"><xsl:value-of select="text()"/></dcterms:description>
    </xsl:template>
    
    <xsl:template match="CPVhlavni" mode="contract">
        <!-- Charakteristika VZ pomocí Společného slovníku pro veřejné zakázky (CPV – Common Procurement Vocabulary),
             který nejlépe popisuje hlavní předmět veřejné zakázky. -->
        <pc:mainObject>
            <skos:Concept>
                <skos:closeMatch>
                    <xsl:call-template name="object"/>
                </skos:closeMatch>
                <xsl:apply-templates select="../CPVdoplnkovy1 | ../CPVdoplnkovy2"/>
            </skos:Concept>
        </pc:mainObject>
    </xsl:template>
    
    <xsl:template match="DruhyPredmetCPVhlavni | TretiPredmetCPVhlavni | CtvrtyPredmetCPVhlavni | PatyPredmetCPVhlavni" mode="contract">
        <xsl:variable name="qualifierElementPrefix" select="replace(name(), 'hlavni$', 'doplnkovy')"/>
        <pc:additionalObject>
            <skos:Concept>
                <skos:closeMatch>
                    <xsl:call-template name="object"/>
                </skos:closeMatch>
                <xsl:apply-templates select="../*[starts-with(name(), $qualifierElementPrefix)]"/>
            </skos:Concept>
        </pc:additionalObject>
    </xsl:template>
    
    <xsl:template match="CPVdoplnkovy1 | CPVdoplnkovy2 | DruhyPredmetCPVdoplnkovy1 | DruhyPredmetCPVdoplnkovy2 |
                         TretiPredmetCPVdoplnkovy1 | TretiPredmetCPVdoplnkovy2 | CtvrtyPredmetCPVdoplnkovy1 |
                         CtvrtyPredmetCPVdoplnkovy2 | PatyPredmetCPVdoplnkovy1 | PatyPredmetCPVdoplnkovy2">
        <!-- CPV qualifier -->
        <skos:related>
            <xsl:call-template name="object"/>
        </skos:related>
    </xsl:template>
    
    <xsl:template match="NaVZseVztahujeGPA" mode="contract">
        <!-- Na zakázku se vztahuje Dohoda o veřejných zakázkách (GPA) -->
        <xsl:call-template name="booleanProperty">
            <xsl:with-param name="property">pc:isGovernmentProcurementAgreement</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="NejnizsiNabidkaVzataVuvahu" mode="contract">
        <!-- Nejnižší uvažovaná nabídka -->
        <pc:lowestConsideredBidPrice>
            <schema:PriceSpecification>
                <xsl:call-template name="price"/>
                <xsl:apply-templates select="../*" mode="lowest-considered-price"/>
            </schema:PriceSpecification>
        </pc:lowestConsideredBidPrice>
    </xsl:template>
    
    <xsl:template match="NejnizsiNabidkaVzataVuvahuMena" mode="lowest-considered-price">
        <!-- Nejnižší uvažovaná nabídka - Měna -->
        <xsl:call-template name="priceCurrency"/>
    </xsl:template>
    
    <xsl:template match="NejnizsiNabidkaVzataVuvahuSazbaDPH" mode="lowest-considered-price">
        <!-- Nejnižší uvažovaná nabídka - Sazba DPH -->
        <xsl:call-template name="valueAddedTax"/>
    </xsl:template>
    
    <xsl:template match="NejnizsiNabidkaVzataVuvahuProcentniSazbaDPH" mode="lowest-considered-price">
        <!-- Nejnižší uvažovaná nabídka - (%) -->
        <xsl:call-template name="valueAddedTaxRate"/>
    </xsl:template>
    
    <xsl:template match="NejvyssiNabidkaVzataVuvahu" mode="contract">
        <!-- Nejvyšší uvažovaná nabídka -->
        <pc:highestConsideredBidPrice>
            <schema:PriceSpecification>
                <xsl:call-template name="price"/>
            </schema:PriceSpecification>
        </pc:highestConsideredBidPrice>
    </xsl:template>
    
    <xsl:template match="DruhRizeni" mode="contract">
        <!-- Druh řízení dle ZVZ -->
        <pc:procedureType>
            <skos:Concept>
                <skos:prefLabel xml:lang="cs"><xsl:value-of select="normalize-space(text())"/></skos:prefLabel>
            </skos:Concept>
        </pc:procedureType>    
    </xsl:template>
    
    <xsl:template match="HlavniKriteriaProZadaniZakazky" mode="contract">
        <!-- Základní hodnotící kritérium pro zadání zakázky (nejnižší nabídková cena nebo ekonomická výhodnost nabídky) -->
        <pc:mainCriterion>
            <skos:Concept>
                <skos:prefLabel xml:lang="cs"><xsl:value-of select="normalize-space(text())"/></skos:prefLabel>
            </skos:Concept>
        </pc:mainCriterion>
    </xsl:template>
    
    <xsl:template match="*[starts-with(name(), 'Kriterium')]" mode="award-criteria-combination">
        <xsl:variable name="number" select="replace(name(), 'Kriterium(\d+)', '$1')"/>
        <pc:awardCriterion>
            <pc:CriterionWeighting>
                <xsl:call-template name="weightedCriterion"/>
                <xsl:apply-templates select="../*[name() = concat('VahaKriteria', $number)]" mode="criterion"/>
            </pc:CriterionWeighting>
        </pc:awardCriterion>
    </xsl:template>
    
    <xsl:template match="*[starts-with(name(), 'VahaKriteria')]" mode="criterion">
        <xsl:call-template name="criterionWeight"/>
    </xsl:template>
    
    <xsl:template match="BylaPouzitaElektronickaDrazba" mode="contract">
        <!-- Byla použita elektronická dražba jako prostředek pro hodnocení nabídek. -->
        <xsl:call-template name="booleanProperty">
            <xsl:with-param name="property">pc:isElectronicAuction</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="ZakazkaSeVztahujeKprojektuFinZes" mode="contract">
        <!-- Veřejná zakázka zcela či zčásti financována z fondů Evropského společenství. -->
        <xsl:call-template name="booleanProperty">
            <xsl:with-param name="property">pc:isFundedFromEUProject</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="ProjektyCiprogramy" mode="contract">
        <!-- Název fondu/programu/projektu, ze kterého je veřejná zakázka financována. -->
        <pc:subsidy>
            <foaf:Project>
                <foaf:name><xsl:value-of select="normalize-space(text())"/></foaf:name>
            </foaf:Project>
        </pc:subsidy>
    </xsl:template>
    
    <xsl:template match="PlatnyFormular" mode="lot">
        <xsl:if test="text() = 'false'">
            <pc:isValid rdf:datatype="&xsd;boolean"><xsl:value-of select="false()"/></pc:isValid>
        </xsl:if>
    </xsl:template>
    
    <!-- Catch-all empty template -->
    <xsl:template match="text()|@*" mode="#all"/>
    
    <!-- Named templates -->
    
    <xsl:template name="booleanProperty">
        <xsl:param name="property" as="xsd:string"/>
        <xsl:element name="{$property}">
            <xsl:attribute name="rdf:datatype">&xsd;boolean</xsl:attribute>
            <xsl:choose>
                <xsl:when test="text() = 'Ano'"><xsl:value-of select="true()"/></xsl:when>
                <xsl:when test="text() = 'Ne'"><xsl:value-of select="false()"/></xsl:when>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="criterionWeight">
        <pc:criterionWeight rdf:datatype="&pcdt;percentage"><xsl:value-of select="text()"/></pc:criterionWeight>
    </xsl:template>
    
    <xsl:template name="dateProperty">
        <xsl:param name="property" as="xsd:string"/>
        <xsl:variable name="date" select="f:transformDate(text())"/>
        <xsl:element name="{$property}">
            <xsl:attribute name="rdf:datatype">
                <xsl:choose>
                    <xsl:when test="f:isValidDate($date)">&xsd;date</xsl:when>
                    <xsl:otherwise>&xsd;string</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="$date"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template name="ico">
        <xsl:param name="ico" as="xsd:string"/>
        <xsl:variable name="tidyIco" select="f:removeWhitespace($ico)"/>
        <rov:registration>
            <adms:Identifier rdf:about="{f:getInstanceUri('Identifier', $tidyIco)}">
                <skos:notation><xsl:value-of select="$tidyIco"/></skos:notation>
                <xsl:choose>
                    <xsl:when test="not(f:isValidIco($tidyIco))">
                        <dcterms:valid rdf:datatype="&xsd;boolean"><xsl:value-of select="false()"/></dcterms:valid>
                    </xsl:when>
                    <xsl:otherwise>
                        <skos:inScheme rdf:resource="http://linked.opendata.cz/resource/concept-scheme/CZ-ICO"/>
                    </xsl:otherwise>
                </xsl:choose>
            </adms:Identifier>
        </rov:registration>
    </xsl:template>
    
    <xsl:template name="object">
        <xsl:param name="cpvSchemeYear" tunnel="yes"/>
        <xsl:variable name="code" select="f:clearCpv(text())"/>
        <skos:Concept>
            <xsl:choose>
                <!-- Test if the object is a CPV code -->
                <xsl:when test="matches($code, '^\d{8}$') or matches($code, '^[A-Z]{2}\d{2}$')">
                    <xsl:attribute name="rdf:about" select="concat(if ($cpvSchemeYear = '2008') then $cpv2008Ns else $cpv2003Ns, $code)"/>
                    <skos:notation><xsl:value-of select="$code"/></skos:notation>
                    <xsl:choose>
                        <xsl:when test="matches($code, '^\d{8}$')">
                            <skos:inScheme rdf:resource="{concat('http://linked.opendata.cz/resource/concept-scheme/cpv-', $cpvSchemeYear)}"/>
                        </xsl:when>
                        <!-- Test if the object is a supplementary CPV code -->
                        <xsl:when test="matches($code, '^[A-Z]{2}\d{2}$')">
                            <skos:inScheme rdf:resource="{concat('http://linked.opendata.cz/resource/concept-scheme/cpv-', $cpvSchemeYear, '-supplement')}"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <skos:notation><xsl:value-of select="text()"/></skos:notation>
                </xsl:otherwise>
            </xsl:choose>
        </skos:Concept>    
    </xsl:template>
    
    <xsl:template name="price">
        <schema:price rdf:datatype="&xsd;decimal"><xsl:value-of select="text()"/></schema:price>
    </xsl:template>
    
    <xsl:template name="priceCurrency">
        <schema:priceCurrency><xsl:value-of select="text()"/></schema:priceCurrency>
    </xsl:template>
    
    <xsl:template name="valueAddedTax">
        <schema:valueAddedTaxIncluded rdf:datatype="&xsd;boolean">
            <xsl:choose>
                <xsl:when test="text() = 'Včetně DPH'"><xsl:value-of select="true()"/></xsl:when>
                <xsl:when test="text() = 'Bez DPH'"><xsl:value-of select="false()"/></xsl:when>
            </xsl:choose>
        </schema:valueAddedTaxIncluded>
    </xsl:template>
    
    <xsl:template name="valueAddedTaxRate">
        <pc:valueAddedTaxRate rdf:datatype="&pcdt;percentage">
            <xsl:choose>
                <xsl:when test="text() = 'Bez DPH'">0</xsl:when>
                <xsl:otherwise><xsl:value-of select="text()"/></xsl:otherwise>
            </xsl:choose>
        </pc:valueAddedTaxRate>
    </xsl:template>
    
    <xsl:template name="weightedCriterion">
        <pc:weightedCriterion>
            <skos:Concept>
                <skos:prefLabel xml:lang="cs"><xsl:value-of select="normalize-space(text())"/></skos:prefLabel>
            </skos:Concept>
        </pc:weightedCriterion>
    </xsl:template>
    
</xsl:stylesheet>