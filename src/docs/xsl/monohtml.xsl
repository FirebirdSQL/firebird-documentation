<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

  <!-- Import the base HTML stylesheets (common to chunked html and monohtml): -->
  <xsl:import href="htmlbase.xsl"/>


  <!-- Below we place all overrides that are specific to the monohtml
       builds. Overrides that should apply to both chunked and mono
       html are placed in htmlbase.xsl -->


  <xsl:variable name="linkbar">
    <tr bgcolor="{$linkbar-bgcolor}">
      <td><a href="{$fb-docindex.url}"><xsl:value-of select="$fb-docindex.title"/></a></td>
      <td align="right"><a href="{$fb-home.url}"><xsl:value-of select="$fb-home.title"/></a></td>
    </tr>
  </xsl:variable>

  <xsl:variable name="spacer">
    <tr height="8"><td/></tr>  <!-- spacer row -->
  </xsl:variable>


  <xsl:template name="user.header.content">
    <xsl:param name="node" select="."/>
    <table width="100%" border="0" cellpadding="4" cellspacing="0">
      <xsl:copy-of select="$linkbar"/>
      <xsl:copy-of select="$spacer"/>
    </table>
    <!-- Firebird logo linking to home page: -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr valign="middle"><xsl:copy-of select="$fb-home-logo"/></tr>
    </table>
  </xsl:template>

  <xsl:template name="user.footer.content">
    <xsl:param name="node" select="."/>
    <table width="100%" border="0" cellpadding="4" cellspacing="0">
      <xsl:copy-of select="$spacer"/>
      <xsl:copy-of select="$linkbar"/>
    </table>
  </xsl:template>

</xsl:stylesheet>

