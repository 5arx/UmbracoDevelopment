<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umbraco.library="urn:umbraco.library"
	exclude-result-prefixes="msxml umbraco.library">


<xsl:output method="xml" omit-xml-declaration="yes"/>

<xsl:param name="currentPage"/>

<xsl:template match="/">



	<xsl:if test="$currentPage/newsImage != ''"> 
            <img alt="{$currentPage/@nodeName}" class="news_image">
              <xsl:attribute name="src">
		<xsl:value-of select="umbraco.library:GetMedia($currentPage/newsImage, false() )/Image/umbracoFile" /> 
              </xsl:attribute>	
            </img>
         </xsl:if>

</xsl:template>

</xsl:stylesheet>