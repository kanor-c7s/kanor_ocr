<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:tei="http://www.tei-c.org/ns/1.0">

   <!-- Import the tei2html stylesheets -->
   <xsl:import href="./tei2html2.xsl"/>

   <!-- Match the entry element -->
   <xsl:template match="tei:entry">
      <html>
         <head>
            <title>
               <xsl:value-of select="tei:form/tei:orth"/>
            </title>
         </head>
         <body>
            <h1>
               <xsl:value-of select="tei:form/tei:orth"/>
            </h1>
            <p>
               <strong>Variant:</strong>
               <xsl:value-of select="tei:form[@type = 'variant']/tei:orth"/>
            </p>
            <p>
               <strong>Part of speech:</strong>
               <xsl:value-of select="tei:gramGrp/tei:gram[@type = 'pos']"/>
            </p>
            <p>
               <strong>Gender:</strong>
               <xsl:value-of select="tei:gramGrp/tei:gram[@type = 'gen']"/>
            </p>
            <p>
               <strong>Sense:</strong>
               <xsl:value-of select="tei:sense[@n = '1']/tei:def"/>
            </p>
            <p>
               <strong>Etymology:</strong>
               <xsl:value-of select="tei:etym"/>
            </p>
            <br/>
         </body>
      </html>
   </xsl:template>
</xsl:stylesheet>
