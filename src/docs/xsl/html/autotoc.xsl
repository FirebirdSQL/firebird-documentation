<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


  <!-- A component (e.g. article) index should be in the ToC: -->

  <xsl:template name="component.toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:param name="toc.title.p" select="true()"/>

    <xsl:call-template name="make.toc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="toc.title.p" select="$toc.title.p"/>
      <xsl:with-param name="nodes" select="section|sect1|refentry
                                           |article|bibliography|glossary
                                           |appendix
                                           |bridgehead[not(@renderas)
                                                       and $bridgehead.in.toc != 0]
                                           |.//bridgehead[@renderas='sect1'
                                                          and $bridgehead.in.toc != 0]
                                           |index"/>  <!-- added index -->
    </xsl:call-template>
  </xsl:template>



  <!-- only refer to setindex in toc if setindex is really gonna be there -->
  <xsl:template match="setindex" mode="toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:if test="count(.//indexentry) > 0 or $generate.index != 0">
      <!-- original first test used to be *, causing setindex toc entry to be
           generated if empty setindex had title! -->
      <xsl:call-template name="subtoc">
        <xsl:with-param name="toc-context" select="$toc-context"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- only refer to index in toc if index is really gonna be there -->
  <xsl:template match="index" mode="toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:if test="count(.//indexentry) > 0 or $generate.index != 0">
      <!-- original first test used to be *, causing index toc entry to be
           generated if empty index had title! -->
      <xsl:call-template name="subtoc">
        <xsl:with-param name="toc-context" select="$toc-context"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  
</xsl:stylesheet>


