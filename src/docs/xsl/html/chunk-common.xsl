<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                version='1.0'>


  <!-- Header logo and navigation: -->
  <xsl:template name="header.navigation">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:call-template name="header-footer.navigation">
      <xsl:with-param name="kind" select="'header'"/>
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>
  </xsl:template>  <!-- end header logo + nav -->


  <!-- Footer navigation: -->
  <xsl:template name="footer.navigation">
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>
    <xsl:call-template name="header-footer.navigation">
      <xsl:with-param name="kind" select="'footer'"/>
      <xsl:with-param name="prev" select="$prev"/>
      <xsl:with-param name="next" select="$next"/>
    </xsl:call-template>
  </xsl:template>  <!-- end footer nav -->


  <xsl:template name="header-footer.navigation">

    <xsl:param name="kind" select="'footer'"/>  <!-- default to footer because that's the "lightest" variant -->
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>

    <xsl:if test="$suppress.navigation = '0'">
    
      <xsl:variable name="zoompath-bgcolor" select="'#F0F0F0'"/>

      <!-- HYPERLINKED ZOOM PATH IN HEADER: -->
      <xsl:if test="$kind='header'">
        <table width="100%" border="0" cellpadding="4" cellspacing="0">
          <tr>
            <td bgcolor="{$zoompath-bgcolor}"><xsl:call-template name="zoompath"/></td>
          </tr>
          <tr height="8"><td/></tr>  <!-- spacer row -->
        </table>
      </xsl:if>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>

          <!-- LINK TO FIREBIRD HOMEPAGE: -->
          <xsl:if test="$kind='header'">
            <td valign="top">
              <a href="http://www.firebirdsql.org/">
                <img src="images/firebirdlogo.png" alt="Firebird home" title="Firebird home"
		       border="0" width="85" height="84"/>
		</a>
            </td>
            <td width="100%">
              <a href="http://www.firebirdsql.org/">
                <img src="images/titleblackgill.gif" alt="Firebird home" title="Firebird home"
                     align="top" border="0" width="215" height="40"/>
		</a>
            </td>
          </xsl:if>

          <!-- CELL WITH NAVIGATION BUTTONS: -->
          <td align="right" height="64"> <!-- creates vert. distance from page text in case of footer -->
            <xsl:attribute name="valign">
              <xsl:choose>
                <xsl:when test="$kind='header'">top</xsl:when>
                <xsl:otherwise>bottom</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>

            <xsl:call-template name="navbuttons">
              <xsl:with-param name="prev" select="$prev"/>
              <xsl:with-param name="next" select="$next"/>
            </xsl:call-template>
          </td>
        </tr>
      </table>

      <!-- HYPERLINKED ZOOM PATH IN FOOTER: -->
      <xsl:if test="$kind='footer'">
        <table width="100%" border="0" cellpadding="4" cellspacing="0">
          <tr height="8"><td/></tr>  <!-- spacer row -->
          <tr>
            <td bgcolor="{$zoompath-bgcolor}"><xsl:call-template name="zoompath"/></td>
          </tr>
        </table>
      </xsl:if>

    </xsl:if>  <!-- test="$suppress.navigation = '0'" -->

  </xsl:template>  <!-- end header/footer logo + nav -->

<!--
  <xsl:template name="getdoc">
    <xsl:param name="node" select="."/>
    <xsl:copy-of select="($node/ancestor-or-self::set
                          |$node/ancestor-or-self::book
                          |$node/ancestor-or-self::article)[last()]"/>
  </xsl:template>
-->

  <xsl:template name="navbuttons">

    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>

    <xsl:variable name="home" select="/*[1]"/>
    <xsl:variable name="up" select="parent::*"/>

    <xsl:variable name="ext" select="'.png'"/>
    <xsl:variable name="sfx" select="'-or18'"/>
    <xsl:variable name="sfx-dim" select="'-dim'"/>

    <!-- PREPARATORY STUFF FOR PREV/NEXT LINKS: -->
<!--
    <xsl:variable name="prevdoc">
      <xsl:call-template name="getdoc"><xsl:with-param name="node" select="$prev"/></xsl:call-template>
    </xsl:variable>
    <xsl:variable name="thisdoc">
      <xsl:call-template name="getdoc"/>
    </xsl:variable>
    <xsl:variable name="nextdoc">
      <xsl:call-template name="getdoc"><xsl:with-param name="node" select="$next"/></xsl:call-template>
    </xsl:variable>
-->
    <xsl:variable name="prevdoc"
      select="($prev/ancestor-or-self::set|$prev/ancestor-or-self::book|$prev/ancestor-or-self::article)[last()]"/>
    <xsl:variable name="thisdoc"
      select="(ancestor-or-self::set|ancestor-or-self::book|ancestor-or-self::article)[last()]"/>
    <xsl:variable name="nextdoc"
      select="($next/ancestor-or-self::set|$next/ancestor-or-self::book|$next/ancestor-or-self::article)[last()]"/>

    <xsl:variable name="prevdoc.id">
      <xsl:call-template name="object.id">
        <xsl:with-param name="object" select="$prevdoc"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="thisdoc.id">
      <xsl:call-template name="object.id">
        <xsl:with-param name="object" select="$thisdoc"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="nextdoc.id">
      <xsl:call-template name="object.id">
        <xsl:with-param name="object" select="$nextdoc"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- LINK TO PREVIOUS: -->
    <xsl:choose>
      <xsl:when test="count($prev)>0 and $thisdoc/ancestor-or-self::*[@id=$prevdoc.id]">
        <a>
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="object" select="$prev"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:variable name="imgtitle">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'nav-prev'"/>
            </xsl:call-template>
            <xsl:text>: </xsl:text>
            <xsl:call-template name="linktitle">
              <xsl:with-param name="node" select="$prev"/>
            </xsl:call-template>
          </xsl:variable>
          <img src="images/prev{$sfx}{$ext}"
               alt="{$imgtitle}" title="{$imgtitle}" width="30" height="30" border="0"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <img src="images/prev{$sfx-dim}{$ext}"
           width="30" height="30" border="0"/>
      </xsl:otherwise>
    </xsl:choose>

    <!-- LINK TO TOC + UP: -->
    <xsl:choose>
      <xsl:when test="count($up)>0">
        <a>
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="object" select="$home"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:variable name="imgtitle">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'nav-home'"/>
            </xsl:call-template>
            <xsl:text>: </xsl:text>
            <xsl:call-template name="linktitle">
              <xsl:with-param name="node" select="$home"/>
            </xsl:call-template>
          </xsl:variable>
          <img src="images/toc{$sfx}{$ext}"
               alt="{$imgtitle}" title="{$imgtitle}" width="30" height="30" border="0"/>
        </a>
        <a>
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="object" select="$up"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:variable name="imgtitle">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'nav-up'"/>
            </xsl:call-template>
            <xsl:text>: </xsl:text>
            <xsl:call-template name="linktitle">
              <xsl:with-param name="node" select="$up"/>
            </xsl:call-template>
          </xsl:variable>
          <img src="images/top{$sfx}{$ext}"
               alt="{$imgtitle}" title="{$imgtitle}" width="30" height="30" border="0"/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <img src="images/toc{$sfx-dim}{$ext}"
           width="30" height="30" border="0"/>
        <img src="images/top{$sfx-dim}{$ext}"
           width="30" height="30" border="0"/>
      </xsl:otherwise>
    </xsl:choose>

    <!-- LINK TO NEXT: -->
    <xsl:choose>
      <xsl:when test="count($next)>0 and $nextdoc/ancestor-or-self::*[@id=$thisdoc.id]">
        <a>
          <xsl:attribute name="href">
            <xsl:call-template name="href.target">
              <xsl:with-param name="object" select="$next"/>
            </xsl:call-template>
          </xsl:attribute>
          <xsl:variable name="imgtitle">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'nav-next'"/>
            </xsl:call-template>
            <xsl:text>: </xsl:text>
            <xsl:call-template name="linktitle">
              <xsl:with-param name="node" select="$next"/>
            </xsl:call-template>
          </xsl:variable>
          <img src="images/next{$sfx}{$ext}"
               alt="{$imgtitle}" title="{$imgtitle}" width="30" height="30" border="0"/>

        </a>
      </xsl:when>
      <xsl:otherwise>
        <img src="images/next{$sfx-dim}{$ext}"
           width="30" height="30" border="0"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>



  <xsl:template name="zoompath">
    <xsl:param name="node" select="."/>

    <xsl:for-each select="$node/ancestor-or-self::*">
      <!-- get a title to show: -->
      <xsl:variable name="displaytitle">
        <xsl:call-template name="linktitle"/>
      </xsl:variable>

      <xsl:if test="position() > 1">
        <xsl:text disable-output-escaping="yes"> &amp;rarr; </xsl:text>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="position() &lt; last()">
          <a>
            <xsl:attribute name="href">
              <xsl:call-template name="href.target">
                <xsl:with-param name="object" select="."/>
              </xsl:call-template>
            </xsl:attribute>
            <xsl:value-of select="$displaytitle"/>
          </a>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$displaytitle"/>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:for-each>
  </xsl:template>



  <xsl:template name="linktitle">
    <!-- Get a title/label to use for a link. Tries in order:
         titleabbrev - title - xreflabel - id - ???           -->
    <xsl:param name="node" select="."/>
    <xsl:param name="with-parent" select="no"/>

    <xsl:if test="$with-parent='yes' and $node/parent::*">
      <xsl:variable name="parenttitle">
        <xsl:call-template name="linktitle">
          <xsl:with-param name="node" select="$node/.."/>
          <xsl:with-param name="with-parent" select="no"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$parenttitle!=''">
        <xsl:value-of select="$parenttitle"/>
        <xsl:text>: </xsl:text>
      </xsl:if>
    </xsl:if>

    <xsl:variable name="nodetitle">
      <!-- titleabbrev.markup returns titleabbrev if available; otherwise it returns title -->
      <xsl:apply-templates select="$node" mode="titleabbrev.markup">
        <xsl:with-param name="allow.anchors" select="0"/>
      </xsl:apply-templates>
    </xsl:variable>

    <xsl:variable name="titletext">
      <xsl:choose>
        <!-- title(abbrev).markup template returns ???TITLE??? if no title(abbrev) found -->
        <xsl:when test="not($nodetitle='' or $nodetitle='???TITLE???')">
          <xsl:value-of select="$nodetitle"/>
        </xsl:when>
        <xsl:when test="$node/@xreflabel and $node/@xreflabel!=''">
          <xsl:value-of select="$node/@xreflabel"/>
        </xsl:when>
        <xsl:when test="$node/@id and $node/@id!=''">
          <xsl:value-of select="$node/@id"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>???</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:value-of select="normalize-space( $titletext )"/>
      <!-- because it may contain newlines that show up ugly in the 
      displayed text -->
  </xsl:template>


</xsl:stylesheet>

