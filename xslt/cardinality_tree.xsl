<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    
    <xsl:output indent="yes"/>
    
    <xsl:key name="parent_path" match="*" use="string-join(ancestor::*/name(), '/')" />
    <xsl:key name="full_path" match="*" use="string-join(ancestor-or-self::*/name(), '/')" />
    
    <xsl:template match="/*" priority="2">
        <xsl:element name="{name()}">
            <xsl:call-template name="element" />
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="*" name="element">
        <xsl:variable name="path" select="string-join(ancestor-or-self::*/name(), '/')" />
        <xsl:for-each-group select="key('parent_path', $path)" group-by="name()">
            <xsl:sort select="current-grouping-key()"/>
            <xsl:element name="{current-grouping-key()}">
                <xsl:variable name="counts" select="key('full_path', $path)/count(*[name() = name(current())])" />
                <xsl:variable name="min" select="min($counts)" />
                <xsl:variable name="max" select="max($counts)"/>
                <xsl:attribute name="minOccurs" select="if (not(contains($path, '/'))) then $max else $min"/>
                <xsl:attribute name="maxOccurs" select="$max"/>
                <xsl:apply-templates select="." />
            </xsl:element>
        </xsl:for-each-group>
    </xsl:template>
</xsl:stylesheet>