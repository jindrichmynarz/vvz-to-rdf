<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
    <!ENTITY criteria "http://purl.org/procurement/public-contracts-criteria#">
    <!ENTITY pc       "http://purl.org/procurement/public-contracts#">
    <!ENTITY pccz     "http://purl.org/procurement/public-contracts-czech#">
    <!ENTITY pcdt     "http://purl.org/procurement/public-contracts-datatypes#">
    <!ENTITY pproc    "http://contsem.unizar.es/def/sector-publico/pproc#">
    <!ENTITY xsd      "http://www.w3.org/2001/XMLSchema#">
]>
<xsl:stylesheet
    xmlns:adms="http://www.w3.org/ns/adms#"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:f="http://opendata.cz/xslt/functions#"
    xmlns:foaf="http://xmlns.com/foaf/0.1/"
    xmlns:gr="http://purl.org/goodrelations/v1#"
    xmlns:local="http://localhost/"
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
    
    <!-- Transformation for public procurement data from electronic marketplaces. -->
    
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
    
    <!-- Templates -->
    
    <xsl:template match="/PrehledZakazekZETrzist">
        <rdf:RDF>
            <xsl:apply-templates/>
        </rdf:RDF>
    </xsl:template>
    
    <xsl:template match="CastiVZ">
        <pproc:Lot rdf:about="{f:getInstanceUri('Lot', concat(VZsystemoveCislo/text(), '-', CastVZcislo/text()))}">
            <xsl:apply-templates mode="lot"/>
        </pproc:Lot>
    </xsl:template>
    
    <xsl:template match="CastVZcislo" mode="lot">
        <!-- Označení části -->
        <adms:identifier>
            <adms:Identifier>
                <skos:notation><xsl:value-of select="text()"/></skos:notation>
                <skos:inScheme rdf:resource="{f:getInstanceUri('ConceptScheme', 'cisla-casti-zadani-vz')}"/>
            </adms:Identifier>
        </adms:identifier>
    </xsl:template>
    
    <xsl:template match="SmluvniCenaBezDPH" mode="lot">
        <!-- Smluvní cena části VZ bez DPH -->
        <pc:agreedPrice>
            <schema:PriceSpecification>
                <xsl:call-template name="valueAddedTax">
                    <xsl:with-param name="included" select="false()"/>
                </xsl:call-template>
                <xsl:call-template name="price"/>
                <xsl:apply-templates select="../*" mode="agreed-price"/>
            </schema:PriceSpecification>
        </pc:agreedPrice>
    </xsl:template>
    
    <xsl:template match="SmluvniCenaVcetneDPH" mode="lot">
        <!-- Smluvní cena části VZ včetně DPH -->
        <pc:agreedPrice>
            <schema:PriceSpecification>
                <xsl:call-template name="valueAddedTax">
                    <xsl:with-param name="included" select="true()"/>
                </xsl:call-template>
                <xsl:call-template name="price"/>
                <xsl:apply-templates select="../*" mode="agreed-price"/>
            </schema:PriceSpecification>
        </pc:agreedPrice>
    </xsl:template>
    
    <xsl:template match="SmluvniCenaMena" mode="agreed-price">
        <!-- Měna celkové smluvní ceny celé VZ včetně DPH -->
        <xsl:call-template name="priceCurrency"/>
    </xsl:template>
    
    <xsl:template match="SmluvniCenaSazbaDPH" mode="agreed-price">
        <!-- Smluvní cena části VZ sazba DPH -->
        <xsl:call-template name="valueAddedTaxRate"/>
    </xsl:template>
    
    <xsl:template match="VZsystemoveCislo" mode="lot">
        <!-- Systémové číslo VZ -->
        <local:isLotOf rdf:resource="{f:getInstanceUri('Contract', text())}"/>
    </xsl:template>
    
    <xsl:template match="Kriteria">
        <pc:AwardCriteriaCombination>
            <xsl:apply-templates mode="criteria"/>
        </pc:AwardCriteriaCombination>
    </xsl:template>
    
    <xsl:template match="DilciHodnoticiKriterium" mode="criteria">
        <!-- Dílčí hodnotící kritéria -->
        <pc:awardCriterion>
            <pc:CriterionWeighting>
                <xsl:call-template name="weightedCriterion"/>
                <xsl:apply-templates select="../*" mode="award-criterion"/>
            </pc:CriterionWeighting>
        </pc:awardCriterion>
    </xsl:template>
    
    <xsl:template match="DilciHodnoticiKriteriumVaha" mode="award-criterion">
        <!-- Váhy přidělené kritériím -->
        <xsl:call-template name="criterionWeight"/>
    </xsl:template>
    
    <xsl:template match="DilciKriteriumCiselneVyjadritelne" mode="award-criterion">
        <!-- Číselně vyjádřitelné kritérium (Ano|Ne) -->
        <xsl:call-template name="booleanProperty">
            <xsl:with-param name="property">local:isNumeric</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="DilciKriteriumPredmetemEaukce" mode="award-criterion">
        <!-- Kritérium předmětem e-aukce (Ano|Ne) -->
        <xsl:call-template name="booleanProperty">
            <xsl:with-param name="property">local:isSubjectOfEAuction</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="DilciKriteriumZadavatelPozadovalVlozeniNabidkovychHodnot" mode="award-criterion">
        <!-- Kritérium, u kterého zadavatel požadoval vložení nabídkových hodnot do nabídkového formuláře (Ano|Ne) -->
        <xsl:call-template name="booleanProperty">
            <xsl:with-param name="property">local:isRequired</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="SubkriteriumCiselneVyjadritelne" mode="award-criterion">
        <!-- Číselně vyjádřitelné kritérium (Ano|Ne) -->
    </xsl:template>
    
    <xsl:template match="SubkriteriumDilcihoKriteria" mode="award-criterion">
        <!-- Subkritéria dílčího hodnotícího kritéria (Ano|Ne) -->
    </xsl:template>
    
    <xsl:template match="SubkriteriumDilcihoKriteriaVaha" mode="award-criterion">
        <!-- Váhy přidělené subkritériím -->
        <xsl:call-template name="criterionWeight"/>
    </xsl:template>

    <xsl:template match="SubkriteriumNabidkoveCeny" mode="award-criterion">
        <!-- Subkritéria nabídkové ceny (Ano|Ne) -->
        <xsl:if test="text() = 'Ano'">
            <pc:awardCriterion>
                <pc:CriterionWeighting>
                    <pc:weightedCriterion rdf:resource="&criteria;Price"/>
                    <xsl:apply-templates select="../*" mode="price-criterion"/>
                </pc:CriterionWeighting>
            </pc:awardCriterion>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="SubkriteriumNabidkoveCenyVaha" mode="price-criterion">
        <!-- Váha přidělená subkritériím -->
        <xsl:call-template name="criterionWeight"/>
    </xsl:template>
    
    <xsl:template match="SubkriteriumPredmetemEaukce" mode="award-criterion">
        <!-- Kritérium předmětem e-aukce (Ano|Ne) -->
        <xsl:call-template name="booleanProperty">
            <xsl:with-param name="property">local:isSubjectOfEAuction</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="SubkriteriumZadavatelPozadovalVlozeniNabidkovychHodnot" mode="award-criterion">
        <!-- Kritérium, u kterého zadavatel požadoval vložení nabídkových hodnot do nabídkového formuláře (Ano|Ne) -->
        <xsl:call-template name="booleanProperty">
            <xsl:with-param name="property">local:isRequired</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="VZsystemoveCislo" mode="criteria">
        <!-- Systémové číslo VZ -->
        <local:isAwardCriteriaCombinationOf rdf:resource="{f:getInstanceUri('Contract', text())}"/>
    </xsl:template>
    
    <xsl:template match="PolozkyVZ">
        <schema:Offer>
            <schema:includesObject>
                <schema:TypeAndQuantityNode></schema:TypeAndQuantityNode>
            </schema:includesObject>
            <schema:itemCondition>
                <schema:OfferItemCondition></schema:OfferItemCondition>
            </schema:itemCondition>
        </schema:Offer>
        <!--
        <xsl:variable name="code" select="f:clearCpv(NIPEZkod/text())"/>
        <skos:Concept rdf:about="{concat('http://linked.opendata.cz/resource/cpv-2008/concept/', $code)}">
            <skos:inScheme rdf:resource="http://linked.opendata.cz/resource/concept-scheme/cpv-2008"/>
            <skos:notation><xsl:value-of select="$code"/></skos:notation>
            <xsl:apply-templates mode="item"/>
        </skos:Concept>
        -->
    </xsl:template>
    
    <xsl:template match="NIPEZdatovyTypVlastnosti" mode="item">
        <!-- Datový typ vlastnosti z číselníku NIPEZ -->    
    </xsl:template>
    
    <xsl:template match="NIPEZhodnotaVlastnosti" mode="item">
        <!-- Hodnota vlastnosti -->
    </xsl:template>
    
    <xsl:template match="NIPEZmernaJednotkaVlastnosti[not(text() = 'null')]" mode="item">
        <!-- Měrná jednotka vlastnosti -->
    </xsl:template>
    
    <xsl:template match="NIPEZnazev" mode="item">
        <!-- Název z číselníku NIPEZ -->
        <skos:prefLabel xml:lang="cs"><xsl:value-of select="text()"/></skos:prefLabel>
    </xsl:template>
    
    <xsl:template match="NIPEZnazevVlastnosti" mode="item">
        <!-- Název vlastnosti -->
    </xsl:template>
    
    <xsl:template match="NIPEZoperatorVlastnosti" mode="item">
        <!-- Operátor (>=|=|<=|min|od|-|do|max|<|>) -->
    </xsl:template>
    
    <xsl:template match="NIPEZpovinnostProEtrziste" mode="item">
        <!-- Povinnost pro e-tržiště -->    
    </xsl:template>
    
    <xsl:template match="VZsystemoveCislo" mode="item">
        <!-- Systémové číslo VZ -->
        <local:isItemOf rdf:resource="{f:getInstanceUri('Contract', text())}"/>
    </xsl:template>
    
    <xsl:template match="ViceDodavatelu">
        <pc:Tender>
            <local:isAwardedTenderOf rdf:resource="{f:getInstanceUri('Lot', concat(VZsystemoveCislo/text(), '-', CastVZcislo/text()))}"/>
            <xsl:apply-templates mode="tender"/>
            <pc:bidder>
                <schema:Organization>
                    <xsl:apply-templates mode="bidder"/>
                    <schema:address>
                        <schema:PostalAddress>
                            <xsl:apply-templates mode="bidder-address"/>
                        </schema:PostalAddress>
                    </schema:address>
                </schema:Organization>
            </pc:bidder>
        </pc:Tender>
    </xsl:template>
    
    <xsl:template match="DatumUzavreniSmlouvy" mode="tender">
        <!-- Datum uzavření smlouvy -->
        <xsl:call-template name="dateProperty">
            <xsl:with-param name="property">local:agreementDate</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="DodavatelStat" mode="bidder-address">
        <!-- Kód státu -->
        <schema:addressCountry><xsl:value-of select="text()"/></schema:addressCountry>
    </xsl:template>
    
    <xsl:template match="DodavatelUredniNazev" mode="bidder">
        <!-- Úřední název dodavatele -->
        <schema:legalName><xsl:value-of select="text()"/></schema:legalName>
    </xsl:template>
    
    <xsl:template match="Zakazky">
        <pc:Contract rdf:about="{f:getInstanceUri('Contract', VZsystemoveCislo/text())}">
            <xsl:apply-templates mode="contract"/>
        </pc:Contract>
    </xsl:template>
    
    <xsl:template match="BylaDoZRzarazenaEaukce" mode="contract">
        <!-- Byla do ZŘ zařazena e-aukce? (Ano|Ne) -->
        <xsl:call-template name="booleanProperty">
            <xsl:with-param name="property">local:isEAuction</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="CelkovaSmluvniCenaBezDPH" mode="contract">
        <!-- Celková smluvní cena celé VZ bez DPH -->
        <pc:agreedPrice>
            <schema:PriceSpecification>
                <xsl:call-template name="price"/>
                <xsl:call-template name="valueAddedTax">
                    <xsl:with-param name="included" select="false()"/>
                </xsl:call-template>
                <xsl:apply-templates select="../*" mode="agreed-price"/>
            </schema:PriceSpecification>
        </pc:agreedPrice>
    </xsl:template>
    
    <xsl:template match="CelkovaSmluvniCenaMena" mode="agreed-price">
        <!-- Měna celkové smluvní ceny celé VZ včetně DPH -->
        <xsl:call-template name="priceCurrency"/>
    </xsl:template>
    
    <xsl:template match="CelkovaSmluvniCenaVcetneDPH">
        <!-- Celková smluvní cena celé VZ včetně DPH -->
        <xsl:call-template name="valueAddedTax">
            <xsl:with-param name="included" select="true()"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="DatumUzavreniSmlouvy">
        <!-- Datum uzavření smlouvy -->
        <xsl:call-template name="dateProperty">
            <xsl:with-param name="property">pc:agreementDate</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="DatumZruseniZadavacihoRizeni">
        <!-- Datum zrušení zadávacího řízení -->
        <xsl:call-template name="dateProperty">
            <xsl:with-param name="property">local:cancellationDate</xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="DelenaNaCasti">
        <!-- Veřejná zakázka rozdělena na části -->
        <rdf:type>
            <xsl:attribute name="rdf:resource">
                <xsl:choose>
                    <xsl:when test="text() = 'Ano'">&pproc;ContractWithLots</xsl:when>
                    <xsl:when test="text() = 'Ne'">&pproc;ContractWithoutLots</xsl:when>
                </xsl:choose>
            </xsl:attribute>
        </rdf:type>
    </xsl:template>
    
    <xsl:template match="DodavatelICO" mode="bidder">
        <!-- IČO dodavatele -->
        <xsl:call-template name="ico">
            <xsl:with-param name="ico" select="text()"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="DodavatelNazev">
        <!-- Úřední název dodavatele (vyplněno v případě jediného dodavatele VZ. Pokud VZ má více dodavatelů jsou uvedeni v sekci Dodavatelé z e-tržiště) -->
    </xsl:template>
    
    <xsl:template match="DruhZadavaciRizeni">
        <!-- Druh zadávacího řízení -->
        <pc:procedureType>
            <skos:Concept>
                <skos:prefLabel xml:lang="cs"><xsl:value-of select="normalize-space(text())"/></skos:prefLabel>
            </skos:Concept>
        </pc:procedureType>
    </xsl:template>
    
    <xsl:template match="MetodaHodnoceni">
        <!-- Metoda hodnocení -->
    </xsl:template>
    
    <xsl:template match="NamitkyPocet">
        <!-- Počet podaných námitek -->    
    </xsl:template>
    
    <xsl:template match="NamitkyVyhoveno">
        <!-- Počet námitek, kterým zadavatel vyhověl -->
    </xsl:template>
    
    <xsl:template match="NazevEtrziste">
        <!-- Název e-tržiště -->
        <schema:name><xsl:value-of select="text()"/></schema:name>
    </xsl:template>
    
    <xsl:template match="PocetCasti">
        <!-- Počet částí VZ -->
    </xsl:template>
    
    <xsl:template match="PocetHodnocenychNabidek">
        <!-- Počet hodnocených nabídek -->
        <local:numberOfConsideredTenders rdf:datatype="&xsd;nonNegativeInteger"><xsl:value-of select="text()"/></local:numberOfConsideredTenders>
    </xsl:template>
    
    <xsl:template match="PocetObdrzenychNabidek">
        <!-- Počet obdržených nabídek ve lhůtě -->
        <pc:numberOfTenders rdf:datatype="&xsd;nonNegativeInteger"><xsl:value-of select="text()"/></pc:numberOfTenders>
    </xsl:template>
    
    <xsl:template match="PocetPolozekVZ">
        <!-- Počet položek VZ -->
    </xsl:template>
    
    <xsl:template match="PocetVyzvanychDodavatelu">
        <!-- Počet dodavatelů, kteří byli vyzváni k podání nabídky -->
    </xsl:template>
    
    <xsl:template match="PredpokladanaHodnotaVZ">
        <!-- Předpokládaná hodnota celé VZ bez DPH -->
        <pc:estimatedPrice>
            <schema:PriceSpecification>
                <xsl:call-template name="valueAddedTax">
                    <xsl:with-param name="included" select="false()"/>
                </xsl:call-template>
                <xsl:call-template name="price"/>
            </schema:PriceSpecification>
        </pc:estimatedPrice>
    </xsl:template>
    
    <xsl:template match="PrezkumUkonu">
        <!-- Byl podán návrh na přezkum úkonů zadavatele u ÚOHS -->
    </xsl:template>
    
    <xsl:template match="PrezkumnychRizeniPocet">
        <!-- Počet přezkumných řízení -->
    </xsl:template>
    
    <xsl:template match="VZdruh">
        <!-- Druh VZ (stavební práce, dodávky, služby) -->
        <pc:kind>
            <skos:Concept>
                <skos:prefLabel xml:lang="cs"><xsl:value-of select="text()"/></skos:prefLabel>
            </skos:Concept>
        </pc:kind>
    </xsl:template>
    
    <xsl:template match="VZstav">
        <!-- Stav VZ. V reportu stav VZ nabývá hodnot Zadávací řízení, Zadáno a Zrušeno.
             VZ ve stavech Specifikace VZ a Ukončeno ve fázi specifikace VZ obsaženy nejsou, neboť tyto se do ISVZ nepřenášejí. -->
    </xsl:template>
    
    <xsl:template match="VZsystemoveCislo">
        <!-- Systémové číslo VZ -->
        <adms:identifier>
            <adms:Identifier>
                <skos:notation><xsl:value-of select="text()"/></skos:notation>
            </adms:Identifier>
        </adms:identifier>
    </xsl:template>
    
    <xsl:template match="VZtyp">
        <!-- Typ VZ (Veřejná zakázka malého rozsahu, Podlimitní veřejná zakázka, Podlimitní veřejná zakázka mimo režim ZVZ) -->
        <pccz:limit></pccz:limit>
    </xsl:template>
    
    <xsl:template match="VysledekZadavacihoRizeni">
        <!-- Výsledek ZŘ (Uzavření rámcové smlouvy, Uzavření jednorázové smlouvy) -->
    </xsl:template>
    
    <xsl:template match="ZadavatelICO">
        <!-- IČO zadavatele -->
        <xsl:call-template name="ico">
            <xsl:with-param name="ico" select="text()"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="ZadavatelKategorie">
        <!-- Kategorie zadavatele -->
        <pc:authorityKind>
            <skos:Concept>
                <skos:prefLabel xml:lang="cs"><xsl:value-of select="normalize-space(text())"/></skos:prefLabel>
            </skos:Concept>
        </pc:authorityKind>
    </xsl:template>
    
    <xsl:template match="ZadavatelNazev">
        <!-- Úřední název zadavatele -->
        <schema:legalName><xsl:value-of select="normalize-space(text())"/></schema:legalName>
    </xsl:template>
    
    <xsl:template match="ZadostioDodatecneInformacePocet">
        <!-- Počet žádostí o dodatečné informace -->
    </xsl:template>
    
    <xsl:template match="ZakladniHodnoticiKriterium">
        <!-- Základní hodnotící kritérium -->
        <local:mainCriterion>
            <skos:Concept>
                <skos:prefLabel xml:lang="cs"><xsl:value-of select="text()"/></skos:prefLabel>
            </skos:Concept>
        </local:mainCriterion>
    </xsl:template>
    
    <xsl:template match="ZruseniVZ">
        <!-- Pokud došlo ke zrušení VZ uvádí se, zda byla zrušena celá VZ nebo jen její část. -->
        <xsl:if test="text() = 'Zrušení celé VZ'">
            <local:isValid rdf:datatype="&xsd;boolean"><xsl:value-of select="false()"/></local:isValid>
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
        <xsl:element name="{$property}">
            <xsl:attribute name="rdf:datatype">
                <xsl:choose>
                    <xsl:when test="text() castable as xsd:dateTime">&xsd;dateTime</xsl:when>
                    <xsl:otherwise>&xsd;string</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:value-of select="text()"/>
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
    
    <xsl:template name="price">
        <schema:price rdf:datatype="&xsd;decimal"><xsl:value-of select="replace(text(), ',', '.')"/></schema:price>
    </xsl:template>
    
    <xsl:template name="priceCurrency">
        <schema:priceCurrency><xsl:value-of select="text()"/></schema:priceCurrency>
    </xsl:template>
    
    <xsl:template name="valueAddedTax">
        <xsl:param name="included" as="xsd:boolean"/>
        <schema:valueAddedTaxIncluded rdf:datatype="&xsd;boolean"><xsl:value-of select="$included"/></schema:valueAddedTaxIncluded>
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