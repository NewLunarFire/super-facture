<?xml version="1.0" encoding="UTF-8"?><!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:util="xalan://org.tsavaria.nocturne.Util" exclude-result-prefixes="fo util">
    <xsl:template match="facture">
        <fo:root>
            <!-- defines the layout master -->
            <fo:layout-master-set>
                <fo:simple-page-master master-name="first" page-height="29.7cm" page-width="21cm" margin-top="1cm"
                                       margin-bottom="2cm" margin-left="2.5cm" margin-right="2.5cm">
                    <fo:region-body margin-top="1cm"/>
                    <fo:region-before extent="1cm"/>
                    <fo:region-after extent="1.5cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <!-- starts actual layout -->
            <fo:page-sequence master-reference="first">
                <fo:flow flow-name="xsl-region-body">

                    <fo:table font-size="8px">
                        <fo:table-column column-width="12mm"/>
                        <fo:table-column column-width="50% - 6mm"/>
                        <fo:table-column column-width="50% - 6mm"/>

                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block><fo:external-graphic content-height="10mm" content-width="10mm" src="url(logo.png)" /></fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block>
                                        <fo:block font-weight="700"><xsl:value-of select="entreprise/nom" /></fo:block>
                                        <fo:block><xsl:value-of select="entreprise/adresse" /></fo:block>
                                        <fo:block><xsl:value-of select="entreprise/codePostal" /></fo:block>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block text-align="right">
                                        <fo:block font-weight="700" margin-bottom="5px">Facture #<xsl:value-of select="format-number(number(id), '00000')"/></fo:block>
                                        <fo:block font-weight="700">Date d'émission</fo:block>
                                        <fo:block><xsl:value-of select="util:formatterDate(emission)" /></fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>

                    <fo:block>
                        <fo:leader leader-pattern="rule" leader-length="100%" rule-style="solid" rule-thickness="2pt"/>
                    </fo:block>

                    <fo:block margin-top="10px" font-size="16px"><xsl:value-of select="entreprise/nom" /></fo:block>
                    <fo:block margin-bottom="20px" font-size="8px">Ajoutez un message ici pour le client</fo:block>

                    <fo:table border-top="solid 1px #cccccc" border-bottom="solid 1px #cccccc" font-size="8px">
                        <fo:table-column column-width="68%"/>
                        <fo:table-column column-width="10%"/>
                        <fo:table-column column-width="10%"/>
                        <fo:table-column column-width="12%"/>

                        <fo:table-header font-weight="700">
                            <fo:table-cell padding-top="5px" padding-bottom="5px">
                                <fo:block>ARTICLE</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-top="5px" padding-bottom="5px" text-align="right">
                                <fo:block>QTÉ</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-top="5px" padding-bottom="5px" text-align="right">
                                <fo:block>PRIX</fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding-top="5px" padding-bottom="5px" text-align="right">
                                <fo:block>MONTANT</fo:block>
                            </fo:table-cell>
                        </fo:table-header>
                        <fo:table-body>
                            <xsl:apply-templates select="item"/>
                            <fo:table-row border-top="solid 1px #cccccc">
                                <fo:table-cell number-columns-spanned="3" padding-top="15px" padding-bottom="5px">
                                    <fo:block>Sous-total</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-top="15px" padding-bottom="5px" text-align="right">
                                    <fo:block><xsl:value-of select="format-number(sousTotal, '0.##')"/>$</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell number-columns-spanned="3" padding-top="5px" padding-bottom="5px">
                                    <fo:block>TPS/TVQ</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-top="5px" padding-bottom="5px" text-align="right">
                                    <fo:block><xsl:value-of select="format-number(taxes, '0.##')"/>$</fo:block>
                                    <!-- <fo:block><xsl:value-of select="util:formatterMontant(number(taxes))"/>$</fo:block> -->
                                    <!--<fo:block><xsl:copy-of select="util:formatterMontant($taxes)"/></fo:block>-->
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row border-top="solid 1px #cccccc" font-weight="700">
                                <fo:table-cell number-columns-spanned="3" padding-top="5px" padding-bottom="5px">
                                    <fo:block>Grand total</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding-top="5px" padding-bottom="5px" text-align="right">
                                    <fo:block><xsl:value-of select="format-number(grandTotal, '0.##')"/>$</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="item">
        <fo:table-row border-top="solid 1px #cccccc">
            <fo:table-cell padding-top="5px" padding-bottom="5px">
                <fo:block>
                    <xsl:value-of select="nom"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding-top="5px" padding-bottom="5px" text-align="right">
                <fo:block>
                    <xsl:value-of select="quantite"/>
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding-top="5px" padding-bottom="5px" text-align="right">
                <fo:block><xsl:value-of select="prix"/>$
                </fo:block>
            </fo:table-cell>
            <fo:table-cell padding-top="5px" padding-bottom="5px" text-align="right">
                <fo:block>0,00$</fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
</xsl:stylesheet>