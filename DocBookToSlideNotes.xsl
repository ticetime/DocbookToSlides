<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:db="http://docbook.org/ns/docbook"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                version="2.0">
    <xsl:output encoding="UTF-8" method="html"/>
    <xsl:variable name="hashtag" select="//db:keyword[@role='hashtag']/text()"/>
    <xsl:param name="displaysTsaapNotes" select="true()"></xsl:param>
    <xsl:param name="tsaapNotesUrl"/>
    <xsl:param name="displaysComments" select="false()"></xsl:param>
    <xsl:template match="/db:article">
        <html>
            <head>
                <meta charset="utf-8"/>
                <title>
                    <xsl:value-of select="db:info/db:title"/>
                </title>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <link href="css/bootstrap.min.css" rel="stylesheet" media="screen"/>
                <style type="text/css">

                    /* Sticky footer styles
                    -------------------------------------------------- */

                    html,
                    body {
                    height: 100%;
                    /* The html and body elements cannot have any padding or margin. */
                    }

                    #footer {
                    height:40px;
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

                    h3 {
                    line-height:20px;
                    }


                    /* Custom page CSS
                    -------------------------------------------------- */
                    /* Not required for template or sticky footer method. */

                    .container {
                    width: auto;
                    max-width: 800px;
                    }
                    .container .credit {
                    margin: 5px 0;
                    }
                    .container .pagination {
                    margin: 5px 0;
                    }

                    .currentslide {
                        margin-top:40px;
                    }

                </style>

                <link href="css/bootstrap-responsive.min.css" rel="stylesheet"/>
            </head>
            <body>
                <div id="footer" class="navbar navbar-fixed-top">
                    <div class="container">
                        <p class="muted credit pull-right">
                            <input type="text" id="slideindex" value="1" style="width:40px"/>
                            /
                            <span id="slidescount"></span>
                        </p>
                        <div class="pagination span2">
                            <ul>
                                <li>
                                    <a onclick="toPrevSlide()" accesskey="p">Prec</a>
                                </li>
                                <li>
                                    <a onclick="toNextSlide()" accesskey=" ">Suiv</a>
                                </li>
                            </ul>
                        </div>
                        <p class="muted credit">
                            <xsl:value-of select="db:info/db:title"/>
                        </p>
                    </div>
                </div>

                <div id="wrap">
                    <xsl:apply-templates select="db:info"/>
                    <xsl:apply-templates select="db:section"/>
                </div>


                <xsl:if test="$displaysTsaapNotes = true()">
                    <div id="tsaap_notes" class="container" style="display:none"></div>
                </xsl:if>

                <script src="js/jquery-1.8.0.js"></script>
                <script src="js/bootstrap.min.js"></script>
                <script>
                    $(document).ready(function () {
                    slides = $('.slide');
                    $("#slidescount").text(slides.size());
                    var currentSlideId = window.location.hash;
                    var elt = $(currentSlideId);
                    var currentSlide = $('.currentslide');
                    if (elt.hasClass('slide')) {
                        updateCurrentSlideWith(currentSlide,elt)
                    }

                    $("#slideindex").change(function() {
                        toSlide($(this).val());
                    });

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
                        var currentSlide = $('.currentslide');
                        var elt = currentSlide.next();
                        if (elt.hasClass('slide')) {
                            updateCurrentSlideWith(currentSlide, elt)
                        } else {
                            updateCurrentSlideWith(currentSlide, slides.first())
                        }
                    }

                    function toSlide(indexSlide) {
                        var currentSlide = $('.currentslide');
                        slides = $('.slide');
                        var indexs = parseInt(indexSlide)-1;
                        var elt = $(slides.get(indexs));
                        if (elt.hasClass('slide')) {
                            updateCurrentSlideWith(currentSlide, elt)
                        } else {
                            updateCurrentSlideWith(currentSlide, slides.first())
                        }
                    }

                    function updateCurrentSlideWith(currentSlide, elt) {
                        // update current slide
                        currentSlide.removeClass('currentslide');
                        currentSlide.css('display', 'none');

                        // update elt slide
                        var slideId = elt.attr("id");
                        window.location.hash = slideId ;
                        elt.css('display', 'block');
                        elt.addClass('currentslide');

                        $("#slideindex").val(slides.index(elt)+1);

                        // display pad

                        if (slideId) {
                            var urlTxt = "<xsl:value-of select="$tsaapNotesUrl"></xsl:value-of>&amp;inline=on&amp;fragmentTagName="+slideId;
                            $("#tsaap_notes").html('<iframe name="embed_readwrite" src="'+ urlTxt +'" width="800" height="600"></iframe>');
                            $("#tsaap_notes").css('display', 'block')
                        } else {
                                $("#tsaap_notes").text('')
                                $("#tsaap_notes").css('display', 'none')
                        }
                    }
                </script>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="db:section[@role='slide']">
        <div class="container slide" style="display:none" id="{@xml:id}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="db:section[@role='comments']">
        <xsl:if test="$displaysComments = true()">
            <hr/>
            <div class="container comments well well-small">
                <xsl:apply-templates/>
            </div>
        </xsl:if>
    </xsl:template>
    <xsl:template match="db:section[@role='comments']/db:title">
        <h4>
            <xsl:value-of select="text()"/>
        </h4>
    </xsl:template>

    <xsl:template match="db:section[@role='slideExcluded']">
    </xsl:template>

    <xsl:template match="db:title">
        <div class="page-header">
            <h3>
                <xsl:value-of select="text()"/>
            </h3>
        </div>
    </xsl:template>
    <xsl:template match="db:link">
        <xsl:choose>
            <xsl:when test="@role = 'gist'">
                <script src="{@xlink:href}.js?file={text()}"></script>
            </xsl:when>
            <xsl:otherwise>
                <a href="{@xlink:href}" title="{text()}" target="_blank">
                    <xsl:value-of select="text()"/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="db:mediaobject">
        <p>
            <img src="{.//db:imagedata/@fileref}" alt="{db:alt}" title="{db:alt}" width="50%"/>
        </p>
    </xsl:template>
    <xsl:template match="db:para">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="db:emphasis">
        <strong>
            <xsl:apply-templates/>
        </strong>
    </xsl:template>
    <xsl:template match="db:note">
        <blockquote>
            <p>
                <strong>
                    <i class="icon-hand-right"></i>
                    Note
                </strong>
            </p>
            <xsl:apply-templates/>
        </blockquote>
    </xsl:template>
    <xsl:template match="db:blockquote">
        <blockquote>
            <xsl:apply-templates select="db:para"/>
            <xsl:apply-templates select="db:attribution"></xsl:apply-templates>
        </blockquote>
    </xsl:template>
    <xsl:template match="db:attribution">
        <small>
            <cite title="{text()}">
                <xsl:apply-templates/>
            </cite>
        </small>
    </xsl:template>
    <xsl:template match="db:computeroutput | db:literallayout | db:code">
        <pre class="prettyprint">
            <xsl:value-of select="text()"/>
        </pre>
    </xsl:template>
    <xsl:template match="db:itemizedlist">
        <ul>
            <xsl:for-each select="db:listitem">
                <li>
                    <xsl:apply-templates/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template match="db:section">
        <div class="container slide" style="display:none" id="{@xml:id}">
            <div class="page-header">
                <h3>
                    <xsl:value-of select="db:title"/>
                </h3>
            </div>
        </div>
        <xsl:apply-templates select="db:section[@role='slide']"/>
    </xsl:template>

    <xsl:template match="db:info">
        <div class="container slide currentslide">
            <div class="page-header">
                <h3>
                    <xsl:value-of select="db:title"/>
                </h3>
            </div>
            <ul>
                <li>Auteur :
                    <xsl:value-of select="db:author/db:personname"/>
                </li>
                <li>Email :
                    <xsl:value-of select="replace(db:author/db:email/text(),'@',' at ')"/>
                </li>
            </ul>
            <blockquote>
                <p>
                    <strong>Condition d'utilisation</strong>
                </p>
                <p>
                    <a href="{db:legalnotice//db:link/@xlink:href}" target="_blank">
                        <xsl:value-of select="db:legalnotice//db:link/text()"/>
                    </a>
                </p>
            </blockquote>
        </div>
    </xsl:template>
</xsl:stylesheet>