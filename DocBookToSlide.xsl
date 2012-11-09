<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:db="http://docbook.org/ns/docbook"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">
    <xsl:output encoding="UTF-8" method="html"/>
    <xsl:template match="/db:article">
    <html>
        <head>
            <meta charset="utf-8" />
            <title><xsl:value-of select="db:info/db:title"/></title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <link href="css/bootstrap.min.css" rel="stylesheet" media="screen" />
            <style type="text/css">
                
                /* Sticky footer styles
                -------------------------------------------------- */
                
                html,
                body {
                height: 100%;
                /* The html and body elements cannot have any padding or margin. */
                }
                
                /* Wrapper for page content to push down footer */
                #wrap {
                min-height: 100%;
                height: auto !important;
                height: 100%;
                /* Negative indent footer by it's height */
                margin: 0 auto -60px;
                }
                
                /* Set the fixed height of the footer here */
                #push,
                #footer {
                height: 60px;
                }
                #footer {
                background-color: #f5f5f5;
                }
                
                /* Lastly, apply responsive CSS fixes as necessary */
                @media (max-width: 767px) {
                #footer {
                margin-left: -20px;
                margin-right: -20px;
                padding-left: 20px;
                padding-right: 20px;
                }
                }
                
                
                
                /* Custom page CSS
                -------------------------------------------------- */
                /* Not required for template or sticky footer method. */
                
                .container {
                width: auto;
                /*max-width: 680px;*/
                }
                .container .credit {
                margin: 20px 0;
                }
                
            </style>
            
            <link href="css/bootstrap-responsive.min.css" rel="stylesheet" />
        </head>
        <body>
            <div id="wrap">
                <xsl:apply-templates select="db:info"/>
                <xsl:apply-templates select="db:section"/>
           
                <div id="push"></div>
            </div>
            
            <div id="footer">
                <div class="container">
                    <p class="muted credit pull-right"><span id="slideindex">1</span> / <span id="slidescount"></span></p>
                    <div class="pagination span2">
                        <ul>
                            <li><a href="#" onclick="toPrevSlide()">Prec</a></li>
                            <li><a href="#" onclick="toNextSlide()">Suiv</a></li>
                        </ul>
                    </div>
                    <p class="muted credit"><xsl:value-of select="db:info/db:title"/></p>
                </div>
            </div>
            
            <script src="http://code.jquery.com/jquery-latest.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script>
                $(document).ready(function () {
                slides = $('.slide')
                $("#slidescount").text(slides.size())
                });
                
                function toPrevSlide() {
                var currentSlide = $('.currentslide')
                var elt = currentSlide.prev()
                if (elt.hasClass('slide')) {
                updateCurrentSlideWith(currentSlide,elt)
                } else {
                updateCurrentSlideWith(currentSlide,slides.last())
                }
                
                
                }
                
                function toNextSlide() {
                var currentSlide = $('.currentslide')
                var elt = currentSlide.next()
                if (elt.hasClass('slide')) {
                updateCurrentSlideWith(currentSlide, elt)
                } else {
                updateCurrentSlideWith(currentSlide, slides.first())
                }
                }
                
                function updateCurrentSlideWith(currentSlide, elt) {
                // update current slide
                
                currentSlide.removeClass('currentslide')
                currentSlide.css('display', 'none')
                
                // update elt slide
                elt.css('display', 'block')
                elt.addClass('currentslide')
                
                $("#slideindex").text(slides.index(elt)+1)
                
                }
            </script>
        </body>
    </html>
    </xsl:template>
    
    <xsl:template match="db:section/db:section">
        <div class="container slide" style="display:none">
            <xsl:apply-templates/>
        </div>    
    </xsl:template>
    <xsl:template match="db:section/db:section/db:title">
        <div class="page-header">
            <h1><xsl:value-of select="text()"/></h1>
        </div>
    </xsl:template>
    <xsl:template match="db:link">
        <a href="{@xlink:href}" title="{text()}" target="_blank"><xsl:value-of select="text()"/></a>
    </xsl:template>
    <xsl:template match="db:mediaobject">
        <p><img src="{.//db:imagedata/@fileref}" alt="{db:alt}" title="{db:alt}"/></p>
    </xsl:template>
    <xsl:template match="db:section/db:para">
        <p class="lead">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="db:para">
            <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="db:note">
        <i class="icon-hand-right pull-left"></i>
        <blockquote>
            <xsl:apply-templates/>
        </blockquote> 
    </xsl:template>
    <xsl:template match="db:blockquote">
        <blockquote>
            <xsl:apply-templates select="db:para"/>
            <xsl:apply-templates select="db:attribution"></xsl:apply-templates>
        </blockquote> 
    </xsl:template>
    <xsl:template match="db:attribution" >
        <small><cite title="{text()}"><xsl:apply-templates/></cite></small>
    </xsl:template>
    <xsl:template match="db:computeroutput | db:literallayout">
        <pre class="prettyprint">
            <xsl:value-of select="text()"/>
        </pre> 
    </xsl:template>
    <xsl:template match="db:itemizedlist">
        <ul>
            <xsl:for-each select="db:listitem">
                <li class="lead">
                    <xsl:apply-templates />
                </li>
            </xsl:for-each>    
        </ul>
    </xsl:template>
    <xsl:template match="db:section">
        <div class="container slide" style="display:none">
            <div class="page-header">
                <h1 style="margin-top:250px;"><xsl:value-of select="db:title"/></h1>
            </div>
        </div>
        <xsl:apply-templates select="./db:section"/>
    </xsl:template>
    
    <xsl:template match="db:info">
        <div class="container slide currentslide">
            <div class="page-header">
                <h1><xsl:value-of select="db:title"/></h1>
            </div>
            <ul>
                <li class="lead">Auteur : <xsl:value-of select="db:author/db:personname"/></li>
                <li class="lead">Email : <xsl:value-of select="replace(db:author/db:email/text(),'@',' at ')"/></li>
            </ul>
            <blockquote>
                <p><strong>Condition d'utilisation</strong></p> 
                <p><a href="{db:legalnotice//db:link/@xlink:href}" target="_blank"><xsl:value-of select="db:legalnotice//db:link/text()"/></a></p>
            </blockquote>
        </div>    
    </xsl:template>
</xsl:stylesheet>