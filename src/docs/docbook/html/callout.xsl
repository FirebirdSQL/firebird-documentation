<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:sverb="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.Verbatim"
                xmlns:xverb="com.nwalsh.xalan.Verbatim"
                xmlns:lxslt="http://xml.apache.org/xslt"
                exclude-result-prefixes="sverb xverb lxslt"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

     ******************************************************************** -->

<lxslt:component prefix="xverb"
                 functions="insertCallouts"/>

<xsl:template match="programlistingco|screenco">
  <xsl:variable name="verbatim" select="programlisting|screen"/>
  <xsl:variable name="vendor" select="system-property('xsl:vendor')"/>

  <xsl:choose>
    <xsl:when test="$use.extensions != '0'
                    and $callouts.extension != '0'">
      <xsl:variable name="rtf">
        <xsl:apply-templates select="$verbatim">
          <xsl:with-param name="suppress-numbers" select="'1'"/>
        </xsl:apply-templates>
      </xsl:variable>

      <xsl:variable name="rtf-with-callouts">
        <xsl:choose>
          <xsl:when test="contains($vendor, 'SAXON ')">
            <xsl:copy-of select="sverb:insertCallouts(areaspec,$rtf)"/>
          </xsl:when>
          <xsl:when test="contains($vendor, 'Apache Software Foundation')">
            <xsl:copy-of select="xverb:insertCallouts(areaspec,$rtf)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:message terminate="yes">
              <xsl:text>Don't know how to do callouts with </xsl:text>
              <xsl:value-of select="$vendor"/>
            </xsl:message>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>

      <xsl:choose>
        <xsl:when test="$verbatim/@linenumbering = 'numbered'
                        and $linenumbering.extension != '0'">
          <div class="{name(.)}">
            <xsl:call-template name="number.rtf.lines">
              <xsl:with-param name="rtf" select="$rtf-with-callouts"/>
              <xsl:with-param name="linenumbering.everyNth"
                              select="$linenumbering.everyNth"/>
              <xsl:with-param name="linenumbering.width"
                              select="$linenumbering.width"/>
              <xsl:with-param name="linenumbering.separator"
                              select="$linenumbering.separator"/>
            </xsl:call-template>
            <xsl:apply-templates select="calloutlist"/>
          </div>
        </xsl:when>
        <xsl:otherwise>
          <div class="{name(.)}">
            <xsl:copy-of select="$rtf-with-callouts"/>
            <xsl:apply-templates select="calloutlist"/>
          </div>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <div class="{name(.)}">
        <xsl:apply-templates/>
      </div>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="areaspec|areaset|area">
</xsl:template>

<xsl:template match="areaset" mode="conumber">
  <xsl:number count="area|areaset" format="1"/>
</xsl:template>

<xsl:template match="area" mode="conumber">
  <xsl:number count="area|areaset" format="1"/>
</xsl:template>

<xsl:template match="co">
  <a name="{@id}"/>
  <xsl:apply-templates select="." mode="callout-bug"/>
</xsl:template>

<xsl:template match="co" mode="callout-bug">
  <xsl:call-template name="callout-bug">
    <xsl:with-param name="conum">
      <xsl:number count="co" format="1"/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="callout-bug">
  <xsl:param name="conum" select='1'/>

  <xsl:choose>
    <xsl:when test="$callout.graphics = '0'
                    or $conum > $callout.graphics.number.limit">

      <xsl:text>(</xsl:text>
      <xsl:value-of select="$conum"/>
      <xsl:text>)</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <img src="{$callout.graphics.path}{$conum}{$callout.graphics.extension}"
           alt="{$conum}" border="0"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
