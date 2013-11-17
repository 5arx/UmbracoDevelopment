<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
        version="1.0" 
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
        xmlns:msxml="urn:schemas-microsoft-com:xslt" 
        xmlns:gecko="urn:gecko-com:xslt"
        xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets" 
        exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets gecko">
<xsl:output method="text" omit-xml-declaration="yes"/>


<msxml:script language="CSharp" implements-prefix="gecko">
<msxml:assembly name="System.Web" />
<msxml:using namespace="System.Web" />
 
<![CDATA[
public void changeOutPut(String ContentType, String FileName) {
        HttpContext.Current.Response.ContentType = ContentType;
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + FileName);
}
]]>

</msxml:script>


<xsl:param name="currentPage"/>
<xsl:template match="/">
<xsl:text>BEGIN:VEVENT</xsl:text><xsl:text>&#xa;</xsl:text>
<xsl:text>SUMMARY:</xsl:text><xsl:value-of select="$currentPage/@nodeName" /><xsl:text>&#xa;</xsl:text>
<xsl:text>LOCATION:</xsl:text><xsl:if test="string($currentPage/eventLocationName) != ''"><xsl:value-of select="$currentPage/eventLocationName"/><xsl:text>, </xsl:text></xsl:if><xsl:call-template name="newLines"><xsl:with-param name="contentToChange" select="$currentPage/eventLocationAddress" /></xsl:call-template><xsl:text>&#xa;</xsl:text>
<xsl:text>DTSTART:</xsl:text><xsl:value-of select="umbraco.library:FormatDateTime($currentPage/eventStartDateTime, 'yyyyMMddTHmm')"/><xsl:text>00z&#xa;</xsl:text>
<xsl:text>DTEND:</xsl:text><xsl:value-of select="umbraco.library:FormatDateTime($currentPage/eventEndDateTime, 'yyyyMMddTHmm')"/><xsl:text>00z&#xa;</xsl:text>
<xsl:text>CLASS:PUBLIC</xsl:text><xsl:text>&#xa;</xsl:text>
<xsl:text>END:VEVENT</xsl:text><xsl:text>&#xa;</xsl:text>
<xsl:value-of select="gecko:changeOutPut('text/calendar','EventExport.ics')" />
</xsl:template>


<xsl:template name="newLines"><xsl:param name="contentToChange" /><xsl:value-of select='umbraco.library:Replace($contentToChange, "&#xd;&#xa;", "\n")'/></xsl:template>

</xsl:stylesheet>
