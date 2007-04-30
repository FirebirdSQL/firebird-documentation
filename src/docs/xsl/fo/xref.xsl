<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:src="http://nwalsh.com/xmlns/litprog/fragment"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="src"
                version="1.0">


  <!-- Give anchor zwsp content, otherwise FOP discards 
       the empty inline and the link target is lost: -->

  <xsl:template match="anchor">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>
    <fo:inline id="{$id}">&#x200B;</fo:inline>
  </xsl:template>


  <!-- hyphenate URLs in ulinks: -->

  <xsl:template match="ulink//text()">
    <xsl:variable name="me" select="string(.)"/>
    <xsl:variable name="url-attr" select="ancestor::ulink[1]/@url"/>
    <xsl:choose>
      <xsl:when test="$me = $url-attr
                      or $me = substring-after($url-attr, ':')
                      or $me = substring-after($url-attr, '//')">
        <xsl:call-template name="hyphenate-url">
          <xsl:with-param name="url" select="$me"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="hyphenate-url">
    <xsl:param name="url" select="''"/>
    <xsl:call-template name="hyphenate-special">
      <xsl:with-param name="str"         select="$url"/>
      <xsl:with-param name="before"      select="$url-hyph.before"/>
      <xsl:with-param name="after"       select="$url-hyph.after"/>
      <xsl:with-param name="not-before"  select="$url-hyph.not-before"/>
      <xsl:with-param name="not-after"   select="$url-hyph.not-after"/>
      <xsl:with-param name="not-between" select="$url-hyph.not-between"/>
      <xsl:with-param name="hyph-char"   select="$url-hyph.char"/>
      <xsl:with-param name="min-before"  select="$url-hyph.min-before"/>
      <xsl:with-param name="min-after"   select="$url-hyph.min-after"/>
    </xsl:call-template>
  </xsl:template>


  <!-- ulink appearance.  TODO: Parameterize color etc.  -->

  <xsl:template match="ulink" name="ulink">
    <fo:basic-link color="#000080" text-decoration="underline" xsl:use-attribute-sets="xref.properties">
      <xsl:attribute name="external-destination">
        <xsl:call-template name="fo-external-image">
          <xsl:with-param name="filename" select="@url"/>
        </xsl:call-template>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="count(child::node())=0">
          <xsl:call-template name="hyphenate-url">
            <xsl:with-param name="url" select="@url"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
  	  <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </fo:basic-link>
  
    <xsl:if test="count(child::node()) != 0
                  and string(.) != @url
                  and $ulink.show != 0">
      <!-- yes, show the URI -->
      <xsl:choose>
        <xsl:when test="$ulink.footnotes != 0 and not(ancestor::footnote)">
          <fo:footnote>
            <xsl:call-template name="ulink.footnote.number"/>
            <fo:footnote-body font-family="{$body.font.family}"
                              font-size="{$footnote.font.size}">
              <fo:block>
                <xsl:call-template name="ulink.footnote.number"/>
                <xsl:text> </xsl:text>
                <fo:inline>
                  <xsl:value-of select="@url"/>
                </fo:inline>
              </fo:block>
            </fo:footnote-body>
          </fo:footnote>
        </xsl:when>
        <xsl:otherwise>
          <fo:inline hyphenate="false">
            <xsl:text> [</xsl:text>
            <xsl:call-template name="hyphenate-url">
              <xsl:with-param name="url" select="@url"/>
            </xsl:call-template>
            <xsl:text>]</xsl:text>
          </fo:inline>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>


  <!-- ==================================================================== -->


  <!-- link -->

  <xsl:template match="link" name="link">
    <xsl:param name="linkend" select="@linkend"/>
    <xsl:param name="targets" select="key('id',$linkend)"/>
    <xsl:param name="target" select="$targets[1]"/>

    <xsl:call-template name="check.id.unique">
      <xsl:with-param name="linkend" select="$linkend"/>
    </xsl:call-template>

    <xsl:variable name="xrefstyle">
      <xsl:choose>
        <xsl:when test="@role and not(@xrefstyle)
                        and $use.role.as.xrefstyle != 0">
          <xsl:value-of select="@role"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@xrefstyle"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <fo:basic-link internal-destination="{$linkend}"
                   xsl:use-attribute-sets="xref.properties">
      <xsl:choose>
        <xsl:when test="count(child::node()) &gt; 0">
          <!-- If it has content, use it -->
          <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
          <!-- else look for an endterm -->
          <xsl:choose>
            <xsl:when test="@endterm">
              <xsl:variable name="etargets" select="key('id',@endterm)"/>
              <xsl:variable name="etarget" select="$etargets[1]"/>
              <xsl:choose>
                <xsl:when test="count($etarget) = 0">
                  <xsl:message>
                    <xsl:value-of select="count($etargets)"/>
                    <xsl:text>Endterm points to nonexistent ID: </xsl:text>
                    <xsl:value-of select="@endterm"/>
                  </xsl:message>
                  <xsl:text>???</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="$etarget" mode="endterm"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>

            <xsl:otherwise>
              <xsl:message>
                <xsl:text>Link element has no content and no Endterm. </xsl:text>
                <xsl:text>Nothing to show in the link to </xsl:text>
                <xsl:value-of select="$target"/>
              </xsl:message>
              <xsl:text>???</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </fo:basic-link>

    <!-- Add standard page reference? -->
    <xsl:choose>
      <!-- negative xrefstyle in instance turns it off -->
      <xsl:when test="starts-with(normalize-space($xrefstyle), 'select:')
                      and contains($xrefstyle, 'nopage')">
      </xsl:when>
      <!-- so does a negative insert.link.page.number -->
      <xsl:when test="$insert.link.page.number = 'no'
                      or $insert.link.page.number = '0'">
      </xsl:when>
      <xsl:when test="($insert.link.page.number = 'yes' or $insert.link.page.number = '1')
                        or
                      ($insert.link.page.number = 'maybe'
                        and (local-name($target) = 'para'
                              or
                            (starts-with(normalize-space($xrefstyle), 'select:')
                                 and (contains($xrefstyle, 'page') or contains($xrefstyle, 'Page')))))">
        <xsl:apply-templates select="$target" mode="page.citation">
          <xsl:with-param name="id" select="$linkend"/>
        </xsl:apply-templates>
      </xsl:when>
    </xsl:choose>
  </xsl:template>




</xsl:stylesheet>
