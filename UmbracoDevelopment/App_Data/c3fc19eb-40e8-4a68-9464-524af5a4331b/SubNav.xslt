<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:Stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
 version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:msxml="urn:schemas-microsoft-com:xslt" xmlns:umbraco.library="urn:umbraco.library" exclude-result-prefixes="msxml 
umbraco.library">

<xsl:output method="html" omit-xml-declaration="yes"/>

<xsl:param name="currentPage"/>

<!-- update this variable on how deep your site map should be -->
<xsl:variable name="maxLevelForSitemap" select="6"/>

<xsl:template match="/">
	<xsl:variable name="parentNode" select="$currentPage/ancestor-or-self::* [@isDoc and @level=2]" />
		<xsl:if test="string($parentNode/@id) != ''">
			<h2><a href="{umbraco.library:NiceUrl($parentNode/@id)}"><xsl:value-of select="$parentNode/@nodeName"/></a></h2> 
			<xsl:call-template name="drawNodes"> 	
					<xsl:with-param name="parent" select="$parentNode"/>  
			</xsl:call-template>
		</xsl:if>
</xsl:template>

<xsl:template name="drawNodes">
	<xsl:param name="parent"/> 
	<xsl:if test="umbraco.library:IsProtected($parent/@id, $parent/@path) = 0 or (umbraco.library:IsProtected($parent/@id, $parent/@path) = 1 and umbraco.library:IsLoggedOn() = 1)">
		<ul class="subnav">
			<xsl:for-each select="$parent/* [@isDoc and string(./umbracoNaviHide) != '1' and @level &lt;= $maxLevelForSitemap and name()!='NewsItem' and name()!='Event' and name()!='DateFolder']">   
				<li>
					<xsl:if test="$currentPage/ancestor-or-self::*/@id = current()/@id">
			            <xsl:attribute name="class">currentli</xsl:attribute>
			        </xsl:if>  
					<a href="{umbraco.library:NiceUrl(@id)}">
					<xsl:if test="$currentPage/ancestor-or-self::*/@id = current()/@id">
			            <xsl:attribute name="class">current</xsl:attribute>
			        </xsl:if>
					<xsl:value-of select="@nodeName"/></a>  
					<xsl:if test="count(./* [@isDoc and string(./umbracoNaviHide) != '1' and @level &lt;= $maxLevelForSitemap]) &gt; 0">   
						<xsl:call-template name="drawNodes">    
						<xsl:with-param name="parent" select="."/>    
						</xsl:call-template>  
					</xsl:if> 
				</li>
			</xsl:for-each>
		</ul>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>