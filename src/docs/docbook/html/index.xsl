<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet [

<!ENTITY primary   'concat(primary/@sortas, primary[not(@sortas)])'>
<!ENTITY secondary 'concat(secondary/@sortas, secondary[not(@sortas)])'>
<!ENTITY tertiary  'concat(tertiary/@sortas, tertiary[not(@sortas)])'>

<!ENTITY section   '(ancestor-or-self::set
                     |ancestor-or-self::book
                     |ancestor-or-self::part
                     |ancestor-or-self::reference
                     |ancestor-or-self::partintro
                     |ancestor-or-self::chapter
                     |ancestor-or-self::appendix
                     |ancestor-or-self::preface
                     |ancestor-or-self::section
                     |ancestor-or-self::sect1
                     |ancestor-or-self::sect2
                     |ancestor-or-self::sect3
                     |ancestor-or-self::sect4
                     |ancestor-or-self::sect5
                     |ancestor-or-self::refsect1
                     |ancestor-or-self::refsect2
                     |ancestor-or-self::refsect3
                     |ancestor-or-self::simplesect
                     |ancestor-or-self::bibliography
                     |ancestor-or-self::glossary
                     |ancestor-or-self::index)[last()]'>

<!ENTITY section.id 'generate-id(&section;)'>
<!ENTITY sep '" "'>
]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>

<!-- ********************************************************************
     $Id$
     ********************************************************************

     This file is part of the XSL DocBook Stylesheet distribution.
     See ../README or http://nwalsh.com/docbook/xsl/ for copyright
     and other information.

     ******************************************************************** -->

<!-- ==================================================================== -->

<xsl:template match="index|setindex">
  <!-- some implementations use completely empty index tags to indicate -->
  <!-- where an automatically generated index should be inserted. so -->
  <!-- if the index is completely empty, skip it. -->

  <xsl:if test="count(*)>0 or $generate.index != '0'">
    <div class="{name(.)}">
      <xsl:call-template name="component.separator"/>
      <xsl:choose>
        <xsl:when test="./title">
          <xsl:apply-templates select="./title" mode="component.title.mode"/>
        </xsl:when>
        <xsl:otherwise>
          <h2 class="title">
            <a>
              <xsl:attribute name="name">
                <xsl:call-template name="object.id"/>
              </xsl:attribute>
              <xsl:call-template name="gentext.element.name"/>
            </a>
          </h2>
        </xsl:otherwise>
      </xsl:choose>

      <xsl:if test="./subtitle">
        <xsl:apply-templates select="./subtitle" mode="component.title.mode"/>
      </xsl:if>

      <xsl:apply-templates/>

      <xsl:if test="count(indexentry) = 0 and count(indexdiv) = 0">
        <xsl:call-template name="generate-index"/>
      </xsl:if>

      <xsl:call-template name="process.footnotes"/>
    </div>
  </xsl:if>
</xsl:template>

<xsl:template match="index/title"></xsl:template>
<xsl:template match="index/subtitle"></xsl:template>
<xsl:template match="index/titleabbrev"></xsl:template>

<xsl:template match="index/title" mode="component.title.mode">
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select=".."/>
    </xsl:call-template>
  </xsl:variable>
  <h2 class="title">
    <a name="{$id}">
      <xsl:apply-templates/>
    </a>
  </h2>
</xsl:template>

<xsl:template match="index/subtitle" mode="component.title.mode">
  <h3>
    <i><xsl:apply-templates/></i>
  </h3>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="indexdiv">
  <div class="{name(.)}">
    <xsl:apply-templates mode="not-indexentrys"/>
    <dl>
      <xsl:apply-templates select="indexentry"/>
    </dl>
  </div>
</xsl:template>

<xsl:template match="indexentry" mode="not-indexentrys">
  <!-- suppress -->
</xsl:template>

<xsl:template match="indexdiv/title">
  <xsl:variable name="id">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select=".."/>
    </xsl:call-template>
  </xsl:variable>
  <h3 class="{name(.)}">
    <a name="{$id}">
      <xsl:apply-templates/>
    </a>
  </h3>
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="indexterm">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <a class="indexterm" name="{$id}"/>
</xsl:template>

<xsl:template match="primary|secondary|tertiary|see|seealso">
</xsl:template>

<!-- ==================================================================== -->

<xsl:template match="indexentry">
  <xsl:apply-templates select="primaryie"/>
</xsl:template>

<xsl:template match="primaryie">
  <dt>
    <xsl:apply-templates/>
  </dt>
  <xsl:choose>
    <xsl:when test="following-sibling::secondaryie">
      <dd>
        <dl>
          <xsl:apply-templates select="following-sibling::secondaryie"/>
        </dl>
      </dd>
    </xsl:when>
    <xsl:when test="following-sibling::seeie
                    |following-sibling::seealsoie">
      <dd>
        <dl>
          <xsl:apply-templates select="following-sibling::seeie
                                       |following-sibling::seealsoie"/>
        </dl>
      </dd>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="secondaryie">
  <dt>
    <xsl:apply-templates/>
  </dt>
  <xsl:choose>
    <xsl:when test="following-sibling::tertiaryie">
      <dd>
        <dl>
          <xsl:apply-templates select="following-sibling::tertiaryie"/>
        </dl>
      </dd>
    </xsl:when>
    <xsl:when test="following-sibling::seeie
                    |following-sibling::seealsoie">
      <dd>
        <dl>
          <xsl:apply-templates select="following-sibling::seeie
                                       |following-sibling::seealsoie"/>
        </dl>
      </dd>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template match="tertiaryie">
  <dt>
    <xsl:apply-templates/>
  </dt>
  <xsl:if test="following-sibling::seeie
                |following-sibling::seealsoie">
    <dd>
      <dl>
        <xsl:apply-templates select="following-sibling::seeie
                                     |following-sibling::seealsoie"/>
      </dl>
    </dd>
  </xsl:if>
</xsl:template>

<xsl:template match="seeie|seealsoie">
  <dt>
    <xsl:apply-templates/>
  </dt>
</xsl:template>

<!-- ==================================================================== -->
<!-- Jeni Tennison gets all the credit for what follows.
     I think I understand it :-) Anyway, I've hacked it a bit, so the
     bugs are mine. -->

<xsl:key name="letter"
         match="indexterm"
         use="substring(&primary;, 1, 1)"/>

<xsl:key name="primary"
         match="indexterm"
         use="&primary;"/>

<xsl:key name="secondary"
         match="indexterm"
         use="concat(&primary;, &sep;, &secondary;)"/>

<xsl:key name="tertiary"
         match="indexterm"
         use="concat(&primary;, &sep;, &secondary;, &sep;, &tertiary;)"/>

<xsl:key name="primary-section"
         match="indexterm[not(secondary) and not(see)]"
         use="concat(&primary;, &sep;, &section.id;)"/>

<xsl:key name="secondary-section"
         match="indexterm[not(tertiary) and not(see)]"
         use="concat(&primary;, &sep;, &secondary;, &sep;, &section.id;)"/>

<xsl:key name="tertiary-section"
         match="indexterm[not(see)]"
         use="concat(&primary;, &sep;, &secondary;, &sep;, &tertiary;, &sep;, &section.id;)"/>

<xsl:key name="see-also"
         match="indexterm[seealso]"
         use="concat(&primary;, &sep;, &secondary;, &sep;, &tertiary;, &sep;, seealso)"/>

<xsl:key name="see"
         match="indexterm[see]"
         use="concat(&primary;, &sep;, &secondary;, &sep;, &tertiary;, &sep;, see)"/>

<xsl:key name="sections" match="*[@id]" use="@id"/>

<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'"/>
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

<xsl:template name="generate-index">
  <xsl:variable name="terms" select="//indexterm[count(.|key('letter',
                                     substring(&primary;, 1, 1))[1]) = 1]"/>
  <xsl:variable name="alphabetical"
                select="$terms[contains(concat($lowercase, $uppercase),
                                        substring(&primary;, 1, 1))]"/>
  <xsl:variable name="others" select="$terms[not(contains(concat($lowercase,
                                                 $uppercase),
                                             substring(&primary;, 1, 1)))]"/>
  <div class="index">
    <xsl:if test="$others">
      <div class="indexdiv">
        <h3>
          <xsl:call-template name="gentext">
            <xsl:with-param name="key" select="'index symbols'"/>
          </xsl:call-template>
        </h3>
        <dl>
          <xsl:apply-templates select="$others[count(.|key('primary',
                                       &primary;)[1]) = 1]"
                               mode="index-primary">
            <xsl:sort select="&primary;"/>
          </xsl:apply-templates>
        </dl>
      </div>
    </xsl:if>
    <xsl:apply-templates select="$alphabetical[count(.|key('letter',
                                 substring(&primary;, 1, 1))[1]) = 1]"
                         mode="index-div">
      <xsl:sort select="&primary;"/>
    </xsl:apply-templates>
  </div>
</xsl:template>

<xsl:template match="indexterm" mode="index-div">
  <xsl:variable name="key" select="substring(&primary;, 1, 1)"/>
  <div class="indexdiv">
    <h3>
      <xsl:value-of select="translate($key, $lowercase, $uppercase)"/>
    </h3>
    <dl>
      <xsl:apply-templates select="key('letter', $key)[count(.|key('primary', &primary;)[1]) = 1]"
                           mode="index-primary">
        <xsl:sort select="&primary;"/>
      </xsl:apply-templates>
    </dl>
  </div>
</xsl:template>

<xsl:template match="indexterm" mode="index-primary">
  <xsl:variable name="key" select="&primary;"/>
  <xsl:variable name="refs" select="key('primary', $key)"/>
  <dt>
    <xsl:value-of select="primary"/>
    <xsl:for-each select="$refs[generate-id() = generate-id(key('primary-section', concat($key, &sep;, &section.id;))[1])]">
      <xsl:apply-templates select="." mode="reference"/>
    </xsl:for-each>
  </dt>
  <xsl:if test="$refs/secondary or $refs[not(secondary)]/*[self::see or self::seealso]">
    <dd>
      <dl>
        <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see', concat(&primary;, &sep;, &sep;, &sep;, see))[1])]"
                             mode="index-see">
          <xsl:sort select="see"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see-also', concat(&primary;, &sep;, &sep;, &sep;, seealso))[1])]"
                             mode="index-seealso">
          <xsl:sort select="seealso"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="$refs[secondary and count(.|key('secondary', concat($key, &sep;, &secondary;))[1]) = 1]" 
                             mode="index-secondary">
          <xsl:sort select="&secondary;"/>
        </xsl:apply-templates>
      </dl>
    </dd>
  </xsl:if>
</xsl:template>

<xsl:template match="indexterm" mode="index-secondary">
  <xsl:variable name="key" select="concat(&primary;, &sep;, &secondary;)"/>
  <xsl:variable name="refs" select="key('secondary', $key)"/>
  <dt>
    <xsl:value-of select="secondary"/>
    <xsl:for-each select="$refs[generate-id() = generate-id(key('secondary-section', concat($key, &sep;, &section.id;))[1])]">
      <xsl:apply-templates select="." mode="reference"/>
    </xsl:for-each>
  </dt>
  <xsl:if test="$refs/tertiary or $refs[not(tertiary)]/*[self::see or self::seealso]">
    <dd>
      <dl>
        <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see', concat(&primary;, &sep;, &secondary;, &sep;, &sep;, see))[1])]"
                             mode="index-see">
          <xsl:sort select="see"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see-also', concat(&primary;, &sep;, &secondary;, &sep;, &sep;, seealso))[1])]"
                             mode="index-seealso">
          <xsl:sort select="seealso"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="$refs[tertiary and count(.|key('tertiary', concat($key, &sep;, &tertiary;))[1]) = 1]" 
                             mode="index-tertiary">
          <xsl:sort select="&tertiary;"/>
        </xsl:apply-templates>
      </dl>
    </dd>
  </xsl:if>
</xsl:template>

<xsl:template match="indexterm" mode="index-tertiary">
  <xsl:variable name="key" select="concat(&primary;, &sep;, &secondary;, &sep;, &tertiary;)"/>
  <xsl:variable name="refs" select="key('tertiary', $key)"/>
  <dt>
    <xsl:value-of select="tertiary"/>
    <xsl:for-each select="$refs[generate-id() = generate-id(key('tertiary-section', concat($key, &sep;, &section.id;))[1])]">
      <xsl:apply-templates select="." mode="reference"/>
    </xsl:for-each>
  </dt>
  <xsl:variable name="see" select="$refs/see | $refs/seealso"/>
  <xsl:if test="$see">
    <dd>
      <dl>
        <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see', concat(&primary;, &sep;, &secondary;, &sep;, &tertiary;, &sep;, see))[1])]"
                             mode="index-see">
          <xsl:sort select="see"/>
        </xsl:apply-templates>
        <xsl:apply-templates select="$refs[generate-id() = generate-id(key('see-also', concat(&primary;, &sep;, &secondary;, &sep;, &tertiary;, &sep;, seealso))[1])]"
                             mode="index-seealso">
          <xsl:sort select="seealso"/>
        </xsl:apply-templates>
      </dl>
    </dd>
  </xsl:if>
</xsl:template>

<xsl:template match="indexterm" mode="reference">
  <xsl:text>, </xsl:text>
  <xsl:choose>
    <xsl:when test="@zone and string(@zone)">
      <xsl:call-template name="reference">
        <xsl:with-param name="zones" select="normalize-space(@zone)"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="&section;"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:apply-templates select="&section;" mode="title.content">
          <xsl:with-param name="text-only" select="'1'"/>
        </xsl:apply-templates>
      </a>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="reference">
  <xsl:param name="zones"/>
  <xsl:choose>
    <xsl:when test="contains($zones, ' ')">
      <xsl:variable name="zone" select="substring-before($zones, ' ')"/>
      <xsl:variable name="target" select="key('sections', $zone)"/>

      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$target[1]"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:apply-templates select="$target[1]" mode="index-title-content"/>
      </a>
      <xsl:text>, </xsl:text>
      <xsl:call-template name="reference">
        <xsl:with-param name="zones" select="substring-after($zones, ' ')"/>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="zone" select="$zones"/>
      <xsl:variable name="target" select="key('sections', $zone)"/>

      <a>
        <xsl:attribute name="href">
          <xsl:call-template name="href.target">
            <xsl:with-param name="object" select="$target[1]"/>
          </xsl:call-template>
        </xsl:attribute>
        <xsl:apply-templates select="$target[1]" mode="index-title-content"/>
      </a>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="indexterm" mode="index-see">
   <dt><xsl:value-of select="see"/></dt>
</xsl:template>

<xsl:template match="indexterm" mode="index-seealso">
   <dt><xsl:value-of select="seealso"/></dt>
</xsl:template>

<xsl:template match="*" mode="index-title-content">
  <xsl:apply-templates select="&section;" mode="title.content">
    <xsl:with-param name="text-only" select="'1'"/>
  </xsl:apply-templates>
</xsl:template>

</xsl:stylesheet>
