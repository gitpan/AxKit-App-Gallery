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

$Id: mergeimageinfo.xsl,v 1.1.1.1 2003/03/29 17:11:49 nik Exp $
-->
 
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  version="1.0">

  <xsl:variable name="cachedir" select="//config/perl-vars/var[@name='GalleryCache']"/>

  <xsl:template match="image">
    <xsl:variable name="imageinfo">
      <xsl:text>file://</xsl:text>
      <xsl:value-of select="$cachedir"/>
      <xsl:text>/</xsl:text>
      <xsl:for-each select="uri/component">
        <xsl:value-of select="e"/>
        <xsl:text>/</xsl:text>
      </xsl:for-each>
      <xsl:value-of select="filename"/>
      <xsl:text>/imageinfo.xml</xsl:text>
    </xsl:variable>

    <image>
      <xsl:copy-of select="*|@*|node()"/>
      <xsl:copy-of select="document($imageinfo)/root/imageinfo"/>
      <xsl:copy-of select="document($imageinfo)/root/thumbs"/>
    </image>
  </xsl:template>

  <xsl:template match="*|@*">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|node()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
