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


  <!-- TEMPLATE FOR THE NAVIGATIONAL AREAS IN HEADER AND FOOTER -->

  <xsl:template name="header-footer.navigation">

    <xsl:param name="kind" select="'footer'"/>  <!-- default to footer because that's the "lightest" variant -->
    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>

    <xsl:if test="$suppress.navigation = '0'">

      <!-- Prepare hyperlinked zoom bar -->
      <xsl:variable name="tr-zoombar">
        <tr><td bgcolor="{$linkbar-bgcolor}"><xsl:call-template name="zoompath"/></td></tr>
      </xsl:variable>

      <!-- Prepare spacer row -->
      <xsl:variable name="spacer">
        <tr height="8"><td/></tr>
      </xsl:variable>


      <!-- HYPERLINKED ZOOM PATH IN HEADER: -->
      <xsl:if test="$kind='header'">
        <table width="100%" border="0" cellpadding="4" cellspacing="0">
          <xsl:copy-of select="$tr-zoombar"/>
          <xsl:copy-of select="$spacer"/>
        </table>
      </xsl:if>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>

          <!-- HEADER ONLY: LOGO LINKING TO FIREBIRD HOMEPAGE: -->
          <xsl:if test="$kind='header'">
            <xsl:copy-of select="$fb-home-logo"/>
          </xsl:if>

          <!-- NAVIGATIONAL BUTTONS: -->
          <td align="right" height="64"> <!-- creates vert. distance from page text in case of footer -->
            <xsl:attribute name="valign">
              <xsl:choose>
                <xsl:when test="$kind='header'">top</xsl:when>
                <xsl:otherwise>bottom</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>

            <xsl:call-template name="make-navbuttons">
              <xsl:with-param name="prev" select="$prev"/>
              <xsl:with-param name="next" select="$next"/>
            </xsl:call-template>
          </td>
        </tr>
      </table>

      <!-- HYPERLINKED ZOOM PATH IN FOOTER: -->
      <xsl:if test="$kind='footer'">
        <table width="100%" border="0" cellpadding="4" cellspacing="0">
          <xsl:copy-of select="$spacer"/>
          <xsl:copy-of select="$tr-zoombar"/>
        </table>
      </xsl:if>

    </xsl:if>  <!-- test="$suppress.navigation = '0'" -->

  </xsl:template>  <!-- end header/footer nav area -->


  <!-- NAVIGATIONAL BUTTONS FOR THE HEADER/FOOTER AREAS -->

  <xsl:template name="make-navbuttons">

    <xsl:param name="prev" select="/foo"/>
    <xsl:param name="next" select="/foo"/>

    <xsl:variable name="home" select="/*[1]"/>
    <xsl:variable name="up" select="parent::*"/>

    <xsl:variable name="self-is-top" select="self::article or self::book or self::set"/>
    <xsl:variable name="next-is-top" select="$next/self::article or $next/self::book or $next/self::set"/>

    <!-- LINK TO PREVIOUS: -->
    <xsl:variable name="yes-prev-link" select="not($self-is-top or count($prev)=0)"/>
    <xsl:variable name="prev.href">
      <xsl:if test="$yes-prev-link">
        <xsl:call-template name="href.target">
          <xsl:with-param name="object" select="$prev"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="prev.title">
      <xsl:if test="$yes-prev-link">
        <xsl:call-template name="linktitle">
          <xsl:with-param name="node" select="$prev"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>
    <xsl:call-template name="put-navicon">
      <xsl:with-param name="type" select="'prev'"/>
      <xsl:with-param name="href" select="$prev.href"/>
      <xsl:with-param name="title" select="$prev.title"/>
    </xsl:call-template>

    <!-- LINK TO DOCUMENTATION INDEX: -->
    <xsl:call-template name="put-navicon">
      <xsl:with-param name="type" select="'toc'"/>
      <xsl:with-param name="href" select="$fb-docindex.url"/>
      <xsl:with-param name="title" select="$fb-docindex.title"/>
    </xsl:call-template>

    <!-- UPWARD LINK: -->
    <xsl:variable name="no-up-doc" select="$self-is-top or count($up)=0"/>
    <xsl:variable name="up.href">
      <xsl:choose>
        <xsl:when test="$no-up-doc">
          <xsl:if test="$nav-up-to-docindex">
            <xsl:value-of select="$fb-docindex.url"/>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$up"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="up.title">
      <xsl:choose>
        <xsl:when test="$no-up-doc">
          <xsl:if test="$nav-up-to-docindex">
            <xsl:value-of select="$fb-docindex.title"/>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="linktitle">
            <xsl:with-param name="node" select="$up"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:call-template name="put-navicon">
      <xsl:with-param name="type" select="'up'"/>
      <xsl:with-param name="href" select="$up.href"/>
      <xsl:with-param name="title" select="$up.title"/>
    </xsl:call-template>

    <!-- LINK TO NEXT: -->
    <xsl:variable name="yes-next-link" select="not($next-is-top or count($next)=0)"/>
    <xsl:variable name="next.href">
      <xsl:if test="$yes-next-link">
        <xsl:call-template name="href.target">
          <xsl:with-param name="object" select="$next"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>
    <xsl:variable name="next.title">
      <xsl:if test="$yes-next-link">
        <xsl:call-template name="linktitle">
          <xsl:with-param name="node" select="$next"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:variable>
    <xsl:call-template name="put-navicon">
      <xsl:with-param name="type" select="'next'"/>
      <xsl:with-param name="href" select="$next.href"/>
      <xsl:with-param name="title" select="$next.title"/>
    </xsl:call-template>

  </xsl:template>


  <!-- Put navigational icon on page, dimmed if href empty, else live -->
  <xsl:template name="put-navicon">
    <xsl:param name="type"/>
    <xsl:param name="href"/>
    <xsl:param name="title"/>

    <xsl:variable name="dir"      select="'images/'"/>
    <xsl:variable name="ext"      select="'.png'"/>
    <xsl:variable name="sfx-live" select="'-or18'"/>
    <xsl:variable name="sfx-dim"  select="'-dim'"/>

    <xsl:variable name="width"    select="30"/>
    <xsl:variable name="height"   select="30"/>
    <xsl:variable name="border"   select="0"/>

    <!-- determine icon url based on type and href -->
    <xsl:variable name="img-url">
      <xsl:value-of select="$dir"/>
      <xsl:choose>
        <xsl:when test="$type='up'">top</xsl:when>
        <xsl:otherwise><xsl:value-of select="$type"/></xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="$href=''"><xsl:value-of select="$sfx-dim"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="$sfx-live"/></xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="$ext"/>
    </xsl:variable>

    <!-- determine caption based on type and href -->
    <xsl:variable name="caption">
      <xsl:if test="$href!=''">
        <xsl:if test="$type!='toc'">
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">
              <xsl:text>nav-</xsl:text>
              <xsl:value-of select="$type"/>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:text>: </xsl:text>
        </xsl:if>
        <xsl:value-of select="$title"/>
      </xsl:if>
    </xsl:variable>

    <!-- prepare image tag -->
    <xsl:variable name="img-element">
      <img src="{$img-url}" width="{$width}" height="{$height}" border="{$border}">
        <xsl:if test="$href!=''">
          <xsl:attribute name="title"><xsl:value-of select="$caption"/></xsl:attribute>
          <xsl:attribute name="alt"><xsl:value-of select="$caption"/></xsl:attribute>
        </xsl:if>
      </img>
    </xsl:variable>
    
    <!-- insert image with or without hyperlink -->
    <xsl:choose>
      <xsl:when test="$href!=''">
        <a href="{$href}"><xsl:copy-of select="$img-element"/></a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="$img-element"/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>


  <!-- ZOOM PATH 
      (line with path from doc index to current page, 
      all elements clickable except current) -->

  <xsl:template name="zoompath">
    <xsl:param name="node" select="."/>

    <a href="{$fb-docindex.url}"><xsl:value-of select="$fb-docindex.title"/></a>

    <xsl:for-each select="$node/ancestor-or-self::*
                            [name(.) != 'set'
                             and (name(.) != 'book' or .//chapter)
                             and (name(.) != 'part' or .//chapter)]">
      <!-- get a title to show: -->
      <xsl:variable name="displaytitle">
        <xsl:call-template name="linktitle"/>
      </xsl:variable>

      <xsl:text disable-output-escaping="yes"> &amp;rarr; </xsl:text>

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


  <!-- Generates title or label for a link: -->

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
