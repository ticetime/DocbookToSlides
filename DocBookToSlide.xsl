<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:db="http://docbook.org/ns/docbook"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="1.0">
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
                max-width: 680px;
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
                
                
                <div class="container slide" style="display:none">
                    <div class="page-header">
                        <h1>Titre du slide 3</h1>
                    </div>
                    <p class="lead">
                        Contenu du slide
                    </p>
                    <ul>
                        <li class="lead">Un item</li>
                        <li class="lead">Un item
                            <ul>
                                <li>Sous item</li>
                                <li>Sous item</li>
                            </ul>
                        </li>
                    </ul>
                    <pre class="prettyprint">
            class Voiture {
            	def couleur
            	def nbPortes
            }
            				</pre>
                    <blockquote>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
                        <small>Someone famous in <cite title="Source Title">Source Title</cite></small>
                    </blockquote>
                </div>
                <div id="push"></div>
            </div>
            
            <div id="footer">
                <div class="container">
                    <p class="muted credit pull-right">n</p>
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
                
                function toPrevSlide() {
                var currentSlide =  $('.currentslide')
                
                var elt = currentSlide.prev()
                if (elt.hasClass('slide')) {
                
                // update current slide
                
                currentSlide.removeClass('currentslide')
                currentSlide.css('display','none')
                
                // update elt slide
                elt.css('display','block')
                elt.addClass('currentslide')
                
                }
                
                }
                
                function toNextSlide() {
                var currentSlide = $('.currentslide')
                
                var elt = currentSlide.next()
                if (elt.hasClass('slide')) {
                
                // update current slide
                
                currentSlide.removeClass('currentslide')
                currentSlide.css('display', 'none')
                
                // update elt slide
                elt.css('display', 'block')
                elt.addClass('currentslide')
                
                }
                }
            </script>
        </body>
    </html>
    </xsl:template>
    
    <xsl:template match="db:section/db:section">
        <div class="container slide" style="display:none">
            <div class="page-header">
                <h1><xsl:value-of select="db:title"/></h1>
            </div>
            
        </div>    
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
                <li class="lead">Email : <xsl:value-of select="db:author/db:email"/></li>
            </ul>
            <blockquote>
                <p><strong>Condition d'utilisation</strong></p> 
                <p><a href="{db:legalnotice//db:link/@xlink:href}" target="_blank"><xsl:value-of select="db:legalnotice//db:link/text()"/></a></p>
            </blockquote>
        </div>    
    </xsl:template>
</xsl:stylesheet>