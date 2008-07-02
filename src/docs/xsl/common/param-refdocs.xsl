<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version='1.0'>


<!--
     param-refdocs.xsl
     ==================
     Here you can specify common (i.e. for HTML *and* FO etc.) parameters for the Reference Documentation builds.
     Params not found here will default to the values in param.xsl
     Params not found in param.xsl will default to the values in manual/tools/docbook-stylesheets/common/param.xsl

     Only include params here if you want to OVERRIDE their default values!
-->


  <!-- PARAMETERS INTRODUCED BY US -->

  <xsl:param name="runinhead.bold"   select="0"/>
  <xsl:param name="runinhead.italic" select="1"/>

</xsl:stylesheet>
