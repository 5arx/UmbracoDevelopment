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

	<xsl:variable name="newsPage" select="$currentPage/homeNewsPage" />
	<xsl:variable name="headMessagePage" select="$currentPage/homeHeadMessagePage" />
	<xsl:if test="string($newsPage) != ''">
		
		<xsl:variable name="newsNode" select="umbraco.library:GetXmlNodeById($newsPage)" />
		
		<ul class="home_news">
			
			<xsl:for-each select="$newsNode//* [@isDoc and string(./umbracoNaviHide) != '1' and name()='NewsItem']">
				<xsl:sort select="current()/newsDate"  order="descending" />	
				<xsl:if test="position() &lt;= 3">
					<li>
						
						
						<xsl:if test="string(current()/newsImage) != ''">
							<div class="news_image">
								<a title="{current()/@nodeName}" href="{umbraco.library:NiceUrl(current()/@id)}">	
									<img>
										<xsl:attribute name="src">
											<!--<xsl:text>/umbraco/ImageGen.ashx?image=</xsl:text>-->
											<xsl:value-of select="umbraco.library:GetMedia(current()/newsImage, false() )/Image/umbracoFile" />
											<!--<xsl:text>&amp;width=80&amp;compression=100</xsl:text>-->
										</xsl:attribute>
										<xsl:attribute name="alt">
											 <xsl:value-of select="current()/@nodeName"/>
										</xsl:attribute>
									</img>
								</a>
							</div>
						</xsl:if>	
						<div class="news_content">
						
							<h3>	<a title="{current()/@nodeName}" href="{umbraco.library:NiceUrl(current()/@id)}">
									<xsl:value-of select="current()/pageHeading"/>
								</a>
							</h3>
							<p><xsl:value-of select="umbraco.library:ReplaceLineBreaks(current()/newsSummary)" disable-output-escaping="yes" /><br />	
							<a href="{umbraco.library:NiceUrl(current()/@id)}">Read more &#187;</a></p>	
						</div>	
					</li>
				</xsl:if>
			</xsl:for-each>
			
		</ul>
		
	</xsl:if>
	
</xsl:template>

</xsl:stylesheet>