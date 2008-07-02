<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>



<xsl:template match="formalpara/title|formalpara/info/title">
  <xsl:variable name="class">
    <xsl:text>formalpara-title</xsl:text>
    <xsl:if test="$runinhead.bold = 1"> bold</xsl:if>
    <xsl:if test="$runinhead.italic = 1"> italic</xsl:if>
  </xsl:variable>
  <span class="{$class}">
    <xsl:call-template name="dress-formalpara-title"/>
  </span>
</xsl:template>



<xsl:template match="revhistory">
  <xsl:variable name="numcols">
    <xsl:choose>
      <xsl:when test=".//authorinitials">4</xsl:when>
      <xsl:otherwise>3</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <div class="{name(.)}">
    <table border="1" width="100%" summary="Revision history">
      <tr valign="top">
        <th align="left" valign="top" colspan="{$numcols}">
          <b>
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'RevHistory'"/>
            </xsl:call-template>
          </b>
        </th>
      </tr>
      <xsl:apply-templates>
        <xsl:with-param name="numcols" select="$numcols"/>
      </xsl:apply-templates>
    </table>
  </div>
</xsl:template>

<xsl:template match="revhistory/revision">
  <xsl:param name="numcols" select="'4'"/>
  <xsl:variable name="revnumber" select=".//revnumber"/>
  <xsl:variable name="revdate"   select=".//date"/>
  <xsl:variable name="revauthor" select=".//authorinitials"/>
  <xsl:variable name="revremark" select=".//revremark|.//revdescription"/>
  <tr valign="top">
    <td align="left">
      <xsl:choose>
        <xsl:when test="$revnumber">
          <xsl:apply-templates select="$revnumber"/>
        </xsl:when>
        <xsl:otherwise>&amp;nbsp;</xsl:otherwise>
      </xsl:choose>
    </td>
    <td align="left">
      <xsl:choose>
        <xsl:when test="$revdate">
          <xsl:apply-templates select="$revdate"/>
        </xsl:when>
        <xsl:otherwise>&amp;nbsp;</xsl:otherwise>
      </xsl:choose>
    </td>
      <xsl:choose>
        <xsl:when test="$revauthor">
          <td align="left">
            <xsl:apply-templates select="$revauthor"/>
          </td>
        </xsl:when>
        <xsl:when test="$numcols &gt; 3">
          <td><xsl:text>&#x00A0;</xsl:text></td>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
      </xsl:choose>
    <td align="left">
      <xsl:choose>
        <xsl:when test="$revremark">
          <xsl:apply-templates select="$revremark"/>
        </xsl:when>
        <xsl:otherwise>&amp;nbsp;</xsl:otherwise>
      </xsl:choose>
    </td>
  </tr>
</xsl:template>

<xsl:template match="revision/revnumber">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/date">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/authorinitials">
  <xsl:text>, </xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/authorinitials[1]" priority="2">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/revremark">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="revision/revdescription">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="revdescription//para">
  <xsl:apply-templates/>
  <br/>
</xsl:template>

</xsl:stylesheet>
