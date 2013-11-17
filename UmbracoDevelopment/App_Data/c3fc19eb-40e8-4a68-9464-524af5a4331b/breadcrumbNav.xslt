<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [  <!ENTITY nbsp "&#x00A0;">]>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxml="urn:schemas-microsoft-com:xslt" 
	xmlns:umbraco.library="urn:umbraco.library" xmlns:Exslt.ExsltCommon="urn:Exslt.ExsltCommon" xmlns:Exslt.ExsltDatesAndTimes="urn:Exslt.ExsltDatesAndTimes" xmlns:Exslt.ExsltMath="urn:Exslt.ExsltMath" xmlns:Exslt.ExsltRegularExpressions="urn:Exslt.ExsltRegularExpressions" xmlns:Exslt.ExsltStrings="urn:Exslt.ExsltStrings" xmlns:Exslt.ExsltSets="urn:Exslt.ExsltSets" 
	exclude-result-prefixes="msxml umbraco.library Exslt.ExsltCommon Exslt.ExsltDatesAndTimes Exslt.ExsltMath Exslt.ExsltRegularExpressions Exslt.ExsltStrings Exslt.ExsltSets ">

  <xsl:output method="xml" omit-xml-declaration="yes"/>

  <xsl:param name="currentPage"/>

  <xsl:variable name="minLevel" select="1"/>

  <xsl:template match="/">

    <xsl:if test="$currentPage/@level &gt; $minLevel">
    <p class="breadcrumb"> <strong>You are here: </strong> <a href="/">Home</a>  &#187;
        <xsl:for-each select="$currentPage/ancestor::* [@isDoc and @level &gt; $minLevel and string(./umbracoNaviHide) != '1' and name()!='NewsItem' and name()!='Event' and name()!='DateFolder']">
            <a href="{umbraco.library:NiceUrl(@id)}">
              <xsl:value-of select="@nodeName"/>
            </a>  &#187;
        </xsl:for-each>
          <xsl:value-of select="$currentPage/@nodeName"/>
      </p>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>