<?xml version="1.0" encoding="ISO-8859-1" ?>

<!-- 
Copyright (c) 2003 Nik Clayton
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
SUCH DAMAGE.

$Id: imagesheet2html.xsl,v 1.1.1.1 2003/03/29 17:11:49 nik Exp $
-->
 
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0">

  <xsl:variable name="thisURI">
    <xsl:text>/</xsl:text>
    <xsl:for-each select="/imagesheet/image/uri/component">
      <xsl:value-of select="u"/>
      <xsl:text>/</xsl:text>
    </xsl:for-each>
    <xsl:value-of select="/imagesheet/image/filename"/>
    <xsl:text>?format=html</xsl:text>
  </xsl:variable>

  <xsl:variable name="currentSize" select="/imagesheet/config/perl-vars/GallerySizes/size[@type='default']"/>

  <xsl:template match="/">
    <html>
      <head>
	<title>Automatically generated imagesheet</title>
      </head>

      <body>
        <p>/
          <xsl:for-each select="/imagesheet/image/uri/component">
            <a>
              <xsl:attribute name="href">
                <xsl:for-each select="./preceding-sibling::component">
                  <xsl:text>/</xsl:text><xsl:value-of select="u"/>
                </xsl:for-each>
                <xsl:text>/</xsl:text><xsl:value-of select="u"/>/<xsl:text/>
              </xsl:attribute>
              <xsl:value-of select="u"/>
            </a> /
          </xsl:for-each>
          <xsl:value-of select="/imagesheet/image/filename"/></p>

	<p align="center"><img>
	  <xsl:attribute name="src"><xsl:value-of select="/imagesheet/image/filename"/>?format=raw;size=<xsl:value-of select="$currentSize"/></xsl:attribute>
	  <xsl:attribute name="height"><xsl:value-of select="//thumb[size = ancestor::image/size]/height"/></xsl:attribute>
          <xsl:attribute name="width"><xsl:value-of select="//thumb[size = ancestor::image/size]/width"/></xsl:attribute></img></p>
   
	<p align="center">Sizes: 
	  <xsl:for-each select="/imagesheet/config/perl-vars/GallerySizes/size">
	    <xsl:if test="./@type != 'thumb'">
	      [ <xsl:choose>
                  <xsl:when test=". = /imagesheet/image/size">
                    <xsl:value-of select="."/>
                  </xsl:when>
                  <xsl:otherwise>
                    <a><xsl:attribute name="href"><xsl:value-of select="concat($thisURI, ';size=', .)"/></xsl:attribute><xsl:value-of select="."/></a>
                  </xsl:otherwise>
                </xsl:choose> ]
	    </xsl:if>
	  </xsl:for-each>
	</p>

	<table align="center">
          <tr>
	    <th align="right">Picture Taken:</th>
	    <td><xsl:value-of select="//imageinfo/DateTimeOriginal"/></td>
	  </tr>

          <tr>
            <th align="right">Exposure:</th>
            <td><xsl:value-of select="//imageinfo/ExposureTime"/> sec</td>
          </tr>

          <tr>
            <th align="right">Full Size:</th>
            <td><xsl:value-of select="//imageinfo/width"/> x <xsl:value-of select="//imageinfo/height"/>, <xsl:value-of select="format-number((//image/filesize div 1024), '#,##0')"/>K</td>
          </tr>

          <tr>
            <th align="right">Camera:</th>
            <td><xsl:value-of select="//imageinfo/Make"/></td>
          </tr>

          <tr>
            <th align="right">Model:</th>
	    <td><xsl:value-of select="//imageinfo/Model"/></td>
          </tr>
	</table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
