<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

  <!-- Import the base HTML stylesheets
       (common to chunked html and monohtml): -->
  <xsl:import href="htmlbase.xsl"/>

  <!-- Below we place all overrides that are specific to the monohtml
       builds. Overrides that should apply to both chunked and mono
       html are placed in htmlbase.xsl -->

  <!-- I wonder why this one is only for monohtml... -->
  <xsl:param name="segmentedlist.as.table" select="1"/>

  <!-- Link bar to place on top and bottom: -->
  <xsl:variable name="bar-bgcolor" select="'#F0F0F0'"/>
  <xsl:variable name="linkbar">
    <tr bgcolor="{$bar-bgcolor}">
      <td><a href="http://www.firebirdsql.org/">Firebird Home</a></td>
      <td align="right"><a href="http://www.firebirdsql.org/?op=doc">Firebird Documentation Index</a></td>
    </tr>
  </xsl:variable>
  <xsl:variable name="spacer">
    <tr height="8"><td/></tr>  <!-- spacer row -->
  </xsl:variable>

  <!-- Display Firebird logo on top of page: -->
  <xsl:template name="user.header.content">
    <xsl:param name="node" select="."/>
    <table width="100%" border="0" cellpadding="4" cellspacing="0">
      <xsl:copy-of select="$linkbar"/>
      <xsl:copy-of select="$spacer"/>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
      <tr valign="middle">
        <td><a href="http://www.firebirdsql.org/"><img src="images/firebirdlogo.png"
            alt="Firebird home" title="Firebird home" border="0" width="85" height="84"/></a></td>
        <td width="100%"><a href="http://www.firebirdsql.org/"><img src="images/titleblackgill.gif"
            alt="Firebird home" title="Firebird home" border="0" width="215" height="40"/></a></td>
      </tr>
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

