<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:Stylesheet [ <!ENTITY nbsp "&#x00A0;"> ]>
<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:msxml="urn:schemas-microsoft-com:xslt"
	xmlns:umbraco.library="urn:umbraco.library"
	exclude-result-prefixes="msxml umbraco.library">


<xsl:output method="xml" omit-xml-declaration="yes"/>

 

<xsl:param name="currentPage"/>


<xsl:template match="/">
 
	
	<xsl:variable name="datenow" select="umbraco.library:CurrentDate()" /> 
	<xsl:variable name="featuredArticle">
		<xsl:choose>
			<xsl:when test="string($currentPage/newsFeaturedArticle) != ''">
				<xsl:value-of select="$currentPage/newsFeaturedArticle" />
			</xsl:when>
			<xsl:otherwise>
				<!-- should support autofolders if we use // -->
				<xsl:for-each select="$currentPage//* [@isDoc and string(./umbracoNaviHide) != '1' and name()='NewsItem']">
					<xsl:sort select="current()/newsDate"  order="descending" />
					<xsl:if test="position() = 1">
						<xsl:value-of select="current()/@id" />
					</xsl:if>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	
	
	<xsl:variable name="recordsPerPage">
		<xsl:choose>
			<xsl:when test="string($currentPage/newsPerPage) != ''">
				<xsl:value-of select="$currentPage/newsPerPage" />
			</xsl:when>
			<xsl:otherwise>15</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="pageNumber" >
		<xsl:choose>
			<xsl:when test="umbraco.library:RequestQueryString('page') &lt;= 0 or string(umbraco.library:RequestQueryString('page')) = '' or string(umbraco.library:RequestQueryString('page')) = 'NaN'">0</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="umbraco.library:RequestQueryString('page')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="numberOfRecords" select="count($currentPage//* [@isDoc and string(./umbracoNaviHide) != '1' and name()='NewsItem' and @id != $featuredArticle])"/>
	<ul class="news_list">
		
		<xsl:call-template name="featuredNewsItem">
			<xsl:with-param name="selectedItem" select="$featuredArticle" />
		</xsl:call-template>
		
		<xsl:for-each select="$currentPage//* [@isDoc and string(./umbracoNaviHide) != '1' and name()='NewsItem' and @id != $featuredArticle]">
			<xsl:sort select="current()/newsDate"  order="descending" />
			<xsl:if test="position() &gt; $recordsPerPage * number($pageNumber) and position() &lt;= number($recordsPerPage * number($pageNumber) + $recordsPerPage )">
				<li>
					<xsl:if test="string(current()/newsImage) != ''">
						<div class="news_image">
							<a title="{current()/@nodeName}" href="{umbraco.library:NiceUrl(current()/@id)}">	
								<img>
									<xsl:attribute name="src">
										<xsl:value-of select="umbraco.library:GetMedia(current()/newsImage, false() )/Image/umbracoFile" />
									</xsl:attribute>
									<xsl:attribute name="alt">
										 <xsl:value-of select="current()/@nodeName"/>
									</xsl:attribute>
								</img>
							</a>
						</div>
					</xsl:if>
					<div class="news_content">
						<h3>
							<a title="{current()/@nodeName}" href="{umbraco.library:NiceUrl(current()/@id)}">
								<xsl:value-of select="current()/pageHeading"/>
							</a>
						</h3>
						<p class="news_date"><xsl:value-of select="umbraco.library:FormatDateTime(./newsDate, 'd MMMM, yyyy')"/></p>
						<p><xsl:value-of select="umbraco.library:ReplaceLineBreaks(./newsSummary)" disable-output-escaping="yes" />&#8230;</p>
						<p><a title="{current()/@nodeName}" href="{umbraco.library:NiceUrl(current()/@id)}">Read full story »</a></p>
					</div>
				</li>
			</xsl:if>
		</xsl:for-each>
		
	</ul>
	<p class="paging">
		<xsl:if test="$pageNumber &gt; 0">
			<a href="?page={$pageNumber -1}">previous</a>	
		</xsl:if>
		
		<!--<xsl:call-template name="for.loop">
			<xsl:with-param name="i">1</xsl:with-param>
			<xsl:with-param name="page" select="$pageNumber +1"></xsl:with-param>
			<xsl:with-param name="count" select="ceiling(count($currentPage/node)div $recordsPerPage)"></xsl:with-param>
		</xsl:call-template>-->
		
		<xsl:if test="(($pageNumber +1 ) * $recordsPerPage) &lt; ($numberOfRecords)">
			<xsl:text>&#160;&#160;&#160;</xsl:text><a href="?page={$pageNumber +1}">next</a>
		</xsl:if>
	&#160;</p>
</xsl:template>

 

<xsl:template name="for.loop">
	<xsl:param name="i"/>
	<xsl:param name="count"/>
	<xsl:param name="page"/>
	
	<xsl:if test="$i &lt;= $count">
		<xsl:if test="$page != $i">
			<a href="{umbraco.library:NiceUrl($currentPage/@id)}?page={$i - 1}" >
				<xsl:value-of select="$i" />
			</a>
			
		</xsl:if>
		<xsl:if test="$page = $i">
			<xsl:value-of select="$i" />
		</xsl:if>
	</xsl:if>

	<xsl:if test="$i &lt;= $count">
		<xsl:call-template name="for.loop">
			<xsl:with-param name="i">
				<xsl:value-of select="$i + 1"/>
			</xsl:with-param>
			<xsl:with-param name="count">
				<xsl:value-of select="$count"/>
			</xsl:with-param>
			<xsl:with-param name="page">
				<xsl:value-of select="$page"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>

</xsl:template>

<xsl:template name="featuredNewsItem">
	
	<xsl:param name="selectedItem" />
	<xsl:variable name="featuredItem" select="umbraco.library:GetXmlNodeById($selectedItem)" />
				
	<li class="featured_news">
		<xsl:if test="string($featuredItem/newsImage) != ''">
			<div class="main_news_image">
				<a title="{$featuredItem/@nodeName}" href="{umbraco.library:NiceUrl($featuredItem/@id)}">	
					<img>
						<xsl:attribute name="src">
							<!--<xsl:text>/umbraco/ImageGen.ashx?image=</xsl:text>-->
							<xsl:value-of select="umbraco.library:GetMedia($featuredItem/newsImage, false() )/Image/umbracoFile" />
							<!--<xsl:text>&amp;width=305&amp;compression=100</xsl:text>-->
						</xsl:attribute>
						<xsl:attribute name="alt">
							 <xsl:value-of select="$featuredItem/newsDate"/>
						</xsl:attribute>
					</img>
				</a>
			</div>
		</xsl:if>
		<div class="main_news_item">
			<h3>
				<a title="{$featuredItem/@nodeName}" href="{umbraco.library:NiceUrl($featuredItem/@id)}">
					<xsl:value-of select="$featuredItem/pageHeading"/>
				</a>
			</h3>
			<p class="news_date"><xsl:value-of select="umbraco.library:FormatDateTime($featuredItem/newsDate, 'd MMMM, yyyy')"/></p>
			<p><xsl:value-of select="umbraco.library:ReplaceLineBreaks($featuredItem/newsSummary)" disable-output-escaping="yes" />...</p>
			<p><a title="{$featuredItem/@nodeName}" href="{umbraco.library:NiceUrl($featuredItem/@id)}">Read full story »</a></p>
		</div>
	</li>
	
</xsl:template>


</xsl:stylesheet>

