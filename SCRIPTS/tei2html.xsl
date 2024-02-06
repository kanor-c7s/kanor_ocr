<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <!-- Template principal -->
    <xsl:template match="/">
        <html>

            <head>
                <title>Kanor et ses frères</title>
                <link rel="stylesheet" type="text/css" href="../../ASSETS/Kanor.css"/>
                <meta http-equiv="cache-control" content="no-cache"/>
                <meta http-equiv="expires" content="0"/>
                <meta http-equiv="pragma" content="no-cache"/>
            </head>
            <body>
                <span class="title">
                    <i>Li histoire de Kanor et de ses freres</i>
                </span>
                <br/>
                <br/>
                <span>Présentation des signes employés :</span>
                <ul>
                    <li>[×] segment indéchiffrable</li>
                    <li> Dieus i vot mostrer de ses o<span class="add">^ue^</span>vres : ajout
                        suscrit par le scribe </li>
                    <li> de grant se<span class="tooltip">‹n›<span class="tooltip-content"/></span>s
                        aornee : ajout par l'éditeur </li>
                    <li> Au conbrer le cheval f<span class="del">u</span>ist il merveille :
                        exponctuation par le scribe </li>
                    <li> et cuida bien avoir l'auwe <span class="surplus">avoir</span> copee. :
                        suppression par l'éditeur </li>
                    <li> je ne <span><i>(s)</i>>&#160;<b>›l‹</b></span>e saroie trover : la
                        correction critique <b>›l‹</b> remplace le texte du ms. </li>
                </ul>
                <br/>
                <hr/>
                <br/>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <!-- Template pour ignorer l'élément teiHeader -->
    <xsl:template match="teiHeader"/>

    <!-- Template pour les titres de rubrique -->


    <!-- Template pour les titres explicites -->
    <xsl:template match="head[@type = 'explicit']">
        <h1>
            <span class="headNum">[<xsl:value-of select="substring-after(@n, 'R')"/>]</span>
            <xsl:text> </xsl:text>
            <xsl:apply-templates/>
        </h1>
    </xsl:template>

    <!-- Template pour les descriptions de figure -->
    <xsl:template match="figDesc">
        <h2>
            <i>
                <span class="figDesc">
                    <xsl:apply-templates/>
                </span>
            </i>
        </h2>
    </xsl:template>

    <!-- Template pour les images -->
    <xsl:template match="graphic[@url]">
        <h2>
            <a href="{@url}" target="_blank" class="GallicaLink">🖼️</a>
        </h2>
    </xsl:template>

    <!-- Template pour les paragraphes -->
    <xsl:template match="p">
        <p>
            <b>§<span class="paraNum"><xsl:value-of select="substring-after(@n, 'P')"/></span></b>
            <xsl:text> </xsl:text>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Template pour les numéros de page -->
    <xsl:template match="pb">
        <sup>
            <span class="pb">[<xsl:value-of select="@n"/>]</span>
            <xsl:text/>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>

    <!-- Template pour les numéros de colonne -->
    <xsl:template match="cb">
        <sup>
            <span class="cb">[<xsl:value-of select="@n"/>]</span>
            <xsl:text/>
            <xsl:apply-templates/>
        </sup>
    </xsl:template>

    <!-- Template pour les numéros -->
    <xsl:template match="num">
        <span class="num">.<xsl:apply-templates/>.</span>
    </xsl:template>


    <!-- Template pour les hi -->

    <!-- Template pour les said
    Utiliser http://xpather.com/ pour tester les chemins
    -->

    <xsl:template match="said">
        <xsl:choose>
            <!-- Template pour les rendition DIALOGUE -->

            <xsl:when test="@rendition = 'dialogue'">
                <xsl:choose>
                    <!-- Condition propre au discours direct avec incise terminale non suivie d'un DD -->
                    <!-- Type : – Et j'en ferai la besougne », dist il. (§§132, 159) -->
                    <!-- On met la virgule à la fin du DD et le script la met après les » -->
                    <!-- Ce test doit être en premier sinon il y a conflit avec un autre test -->

                    <xsl:when
                        test="preceding-sibling::said and not(following-sibling::said[1][@rendition = 'dialogue']) and ends-with(., ',')">
                        <br/> – <xsl:value-of select="substring(., 1, string-length(.) - 1)"
                        />&#xA0;», </xsl:when>

                    <!-- ça c'est à revoir -->
                    <xsl:when
                        test="position() = last() and following-sibling::node()[1][self::said[@rendition = 'dialogue']]">
                        <br/> «&#xA0;<xsl:apply-templates/></xsl:when>

                    <xsl:when
                        test="preceding-sibling::said and following-sibling::said[1][@rendition = 'dialogue']">
                        <br/> – <xsl:apply-templates/>
                    </xsl:when>

                    <xsl:when
                        test="preceding-sibling::said or position() = 1 and not(following-sibling::said[1][@rendition = 'dialogue']) and ends-with(., '.')">
                        <br/> – <xsl:apply-templates/>&#xA0;»<br/>
                    </xsl:when>

                    <xsl:when
                        test="preceding-sibling::said and not(following-sibling::said[1][@rendition = 'dialogue']) and ends-with(., '?')">
                        <br/> – <xsl:apply-templates/>&#xA0;»<br/>
                    </xsl:when>

                    <xsl:when
                        test="preceding-sibling::said and not(following-sibling::said[1][@rendition = 'dialogue']) and ends-with(., '!')">
                        <br/> – <xsl:apply-templates/>&#xA0;»<br/>
                    </xsl:when>

                    <xsl:when
                        test="preceding-sibling::said and not(following-sibling::said[1][@rendition = 'dialogue']) and not(matches(., '^.*[\.!\?]$'))">
                        <br/> – <xsl:apply-templates/>&#xA0;»</xsl:when>

                    <!-- Ajout d'une condition spécifique à <said> lorsqu'un @rendition=dialogue chevauche un <p> (ex. par. 59-60)
                        On modifie la condition de test pour qu’elle ne dépende pas du contexte de l’élément <said>
                    Voir d'ailleurs s'il n'est pas plus économique de supprimer la prise en compte du contexte 
                    pour tous les tests concernant <said>, <p> n'ayant pas de rapport.
                    <xsl:when
                        test="//preceding-sibling::said and //following-sibling::said[1][@rendition = 'dialogue']">
                        <br/> – <xsl:apply-templates/>
                    </xsl:when>-->
                </xsl:choose>
            </xsl:when>

            <!-- Template pour les débuts DIALOGUE -->

            <xsl:when test="position() = 1 and following-sibling::said[@rendition = 'dialogue']"> -
                <xsl:apply-templates/></xsl:when>

            <xsl:when test="@direct = 'true' and @aloud = 'true' and not(@rendition = 'dialogue')">
                <xsl:choose>
                    <!-- Template pour les débuts DIALOGUE qui ont une suite dans le même <p> -->
                    <xsl:when test="following-sibling::said[1][@rendition = 'dialogue']">
                        <br/> «&#xA0;<xsl:apply-templates/></xsl:when>

                    <!-- Template pour les spécifiques pour les discours type "dis me tu" -->
                    <xsl:when test="@style = 'nogap'"
                        >«&#xA0;<xsl:apply-templates/>&#xA0;»</xsl:when>

                    <!-- Condition propre au discours direct avec incise terminale non précédée ou suivie d'un DD -->
                    <!-- Type : – Et j'en ferai la besougne ! » dist il. -->
                    <xsl:when
                        test="not(preceding-sibling::said[1][@rendition = 'dialogue']) and not(following-sibling::said[1][@rendition = 'dialogue']) and ends-with(., '!')">
                        <br/> «&#xA0;<xsl:apply-templates/>&#xA0;» </xsl:when>

                    <!-- Condition propre au discours direct avec incise terminale non précédée ou suivie d'un DD -->
                    <!-- Type : – Et j'en ferai la besougne », dist il. -->
                    <!-- On met la virgule à la fin du DD et le script la met après les » -->
                    <xsl:when
                        test="not(preceding-sibling::said[1][@rendition = 'dialogue']) and not(following-sibling::said[1][@rendition = 'dialogue']) and ends-with(., ',')">
                        <br/> «&#xA0;<xsl:value-of select="substring(., 1, string-length(.) - 1)"
                        />&#xA0;», </xsl:when>

                    <!-- Condition propre au discours direct avec incise terminale non précédée ou suivie d'un DD -->
                    <!-- Type : – Et j'en ferai la besougne ? » dist il. -->
                    <xsl:when
                        test="not(preceding-sibling::said[1][@rendition = 'dialogue']) and not(following-sibling::said[1][@rendition = 'dialogue']) and ends-with(., '?')">
                        <br/> «&#xA0;<xsl:apply-templates/>&#xA0;» </xsl:when>

                    <xsl:otherwise>
                        <br/> «&#xA0;<xsl:apply-templates/>&#xA0;»<br/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="@direct = 'true' and @aloud = 'true' and @next">
                <br/> «&#xA0;<xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="@direct = 'true' and @aloud = 'true' and @xml:id">
                <xsl:apply-templates/>&#xA0;»<br/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template pour les éléments del -->
    <xsl:template match="del">
        <span class="del">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Template pour les éléments surplus -->
    <xsl:template match="surplus">
        <span class="surplus">
            <xsl:apply-templates/>
        </span>
    </xsl:template>


    <!-- Template pour les éléments app -->
    <xsl:template match="app">
        <span class="tooltip">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Template pour les éléments rdg -->
    <xsl:template match="rdg">
        <span class="tooltip-content">
            <xsl:apply-templates/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="translate(@wit, '#', '')"/>
        </span>
    </xsl:template>

    <!-- Template pour les éléments lem -->
    <xsl:template match="lem">
        <span class="lem">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Template pour les éléments supplied -->
    <xsl:template match="supplied">
        <span class="tooltip">
            <xsl:choose>
                <xsl:when test="@source = '#FPZ'">[<xsl:apply-templates/>]</xsl:when>
                <xsl:otherwise>‹<xsl:apply-templates/>›</xsl:otherwise>
            </xsl:choose>
            <span class="tooltip-content">
                <xsl:value-of select="@source"/>
            </span>
        </span>
    </xsl:template>

    <!-- Template pour les éléments note -->
    <xsl:template match="note">
        <xsl:choose>
            <xsl:when test="@type = 'notecritique'">
                <span class="tooltip">
                    <span class="note">💬<span class="tooltip-content">
                            <xsl:apply-templates/>
                        </span></span>
                </span>
            </xsl:when>
            <xsl:when test="@type = 'ntravail'">
                <span class="tooltip">
                    <span class="ntravail">&#160;&#10067;<span class="tooltip-content">
                            <xsl:apply-templates/>
                        </span></span>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="tooltip">
                    <span class="note">💬<span class="tooltip-content">
                            <xsl:apply-templates/>
                        </span></span>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template pour les éléments add -->
    <xsl:template match="add">
        <span class="add">^<xsl:apply-templates/>^</span>
    </xsl:template>

    <!-- Template pour les éléments hi -->
    <xsl:template match="hi">
        <xsl:choose>
            <xsl:when test="starts-with(@rend, 'rubricated')">
                <span class="rubricated">
                    <span class="headNum">[<xsl:value-of select="ancestor::div[1]/head/@n"/>]</span>
                    <xsl:text> </xsl:text>
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@rend = 'exp'">
                <sup>
                    <span class="exp">
                        <xsl:apply-templates/>
                    </span>
                </sup>
            </xsl:when>
            <xsl:when test="@rend = 'italique'">
                <i>
                    <xsl:apply-templates/>
                </i>
            </xsl:when>
            <xsl:when test="starts-with(@rend, 'decorated-initial')">
                <span class="lettrine" style="color:dark{tokenize(@rend, '\s+')[3]}">
                    <i>
                        <xsl:apply-templates/>
                    </i>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>









    <!-- Template pour les éléments persName -->
    <xsl:template match="persName">
        <span class="persName">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Template pour les éléments placeName -->
    <xsl:template match="placeName">
        <span class="placeName">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- Template pour les éléments rs -->
    <xsl:template match="rs">
        <span class="tooltip">
            <span class="rs">
                <xsl:apply-templates/>
                <span class="tooltip-content">
                    <xsl:value-of select="@key"/>
                </span>
            </span>
        </span>
    </xsl:template>

    <!-- Template pour les éléments rs avec type = 'people' -->
    <xsl:template match="rs[@type = 'people']">
        <span class="tooltip">
            <span class="people">
                <xsl:apply-templates/>
                <span class="tooltip-content">
                    <xsl:value-of select="@key"/>
                </span>
            </span>
        </span>
    </xsl:template>

    <!-- Template pour les éléments rs avec type = 'place' -->
    <xsl:template match="rs[@type = 'place']">
        <span class="tooltip">
            <span class="place">
                <xsl:apply-templates/>
                <span class="tooltip-content">
                    <xsl:value-of select="@key"/>
                </span>
            </span>
        </span>
    </xsl:template>

    <!-- Template pour les éléments seg -->
    <xsl:template match="seg">
        <xsl:choose>
            <xsl:when test="@ana = 'lettre'">"<xsl:apply-templates/>"</xsl:when>
            <xsl:when test="@ana = 'chanson'">"<xsl:apply-templates/>"</xsl:when>
            <xsl:otherwise>'<xsl:apply-templates/>'</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template pour les éléments unclear -->
    <xsl:template match="unclear">
        <xsl:choose>
            <xsl:when test="@type = 'arevoir'">
                <span class="arevoir">
                    <i>[<xsl:apply-templates/>]</i>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <i>[<xsl:apply-templates/>]</i>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template pour les éléments gap -->
    <xsl:template match="gap">
        <xsl:choose>
            <xsl:when test="@reason = 'illegible'">
                <b>[×]</b>
            </xsl:when>
            <xsl:otherwise>
                <i>[<xsl:apply-templates/>]</i>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template pour les éléments choice -->
    <xsl:template match="choice">
        <span><i>(<xsl:value-of select="orig"/>)</i>&#160;<b>›<xsl:value-of select="reg"
            />‹</b></span>
    </xsl:template>
</xsl:stylesheet>
