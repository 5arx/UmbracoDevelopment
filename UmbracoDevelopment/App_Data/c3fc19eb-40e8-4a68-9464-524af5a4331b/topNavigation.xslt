<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets" 
	exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets ">


<xsl:output method="xml" omit-xml-declaration="yes"/>

<xsl:param name="currentPage"/>

<xsl:template match="/">

	<!-- 
		Find the homepage (the topmost node in this tree section, with a doctype alias of 'homepage')
	-->
	<xsl:variable name="homePageNode" select="$currentPage/ancestor-or-self::root/* [@isDoc and name()='Homepage']" />
	
	
	<ul class="nav">
		<!-- we can assume that we'll need a homepage link in this nav -->
		<li>
			<xsl:if test="$currentPage/ancestor-or-self::* [@level=1]/@id = current()/@id">
				<xsl:attribute name="class">current</xsl:attribute>
			</xsl:if>
			<!-- NiceUrl takes a node ID and gives us a 'nice url' to the page -->
			<a href="{umbraco.library:NiceUrl($homePageNode/@id)}">
				<xsl:value-of select="$homePageNode/@nodeName" />
			</a>
		</li>
		
		<!-- this loop takes all of the direct children of the homepage that aren't currently hidden -->
		<xsl:for-each select="$homePageNode/* [@isDoc and string(./umbracoNaviHide) != '1']">
			
			<li>
				<!-- a test to set the class of the link to the current page to 'current' 
				
					basically it says:  If the current page or one if its parents has a node id equal to the id of the current page, 
					set class to current
				-->
				<xsl:if test="$currentPage/ancestor-or-self::*/@id = current()/@id">
					<xsl:attribute name="class">current</xsl:attribute>
		        </xsl:if>
				<a href="{umbraco.library:NiceUrl(current()/@id)}">
					<xsl:value-of select="current()/@nodeName" />
				</a>
			</li>
			
		</xsl:for-each>
		
		
	</ul>
	
</xsl:template>

</xsl:stylesheet>