package com.hopcroft.grails.cityfinder.service

import com.hopcroft.grails.cityfinder.domain.City

class InformationService {

    static transactional = true

    def getWikipediaInformation(City cityInstance) {
		//wikipedia.
		cityInstance.name = cityInstance.name.trim()
		//println "Hago trim " + cityInstance.name + "_"
		def wikiName = cityInstance.name.replaceAll(/\s/,'_')
		//println "wikiName " + wikiName
		def url_wikipedia = "http://en.wikipedia.org/wiki/" + wikiName;
		//println "url_wikipedia " + url_wikipedia
		def xml_wikipedia = url_wikipedia.toURL().text
		//TODO: aprender a parsear rapidamente para coger los dos primeros parrafos de la wikipedia
		/*
		 println "XML_WIKIPEDIA " + xml_wikipedia
		 def parser = new org.cyberneko.html.parsers.SAXParser()
		 //parser.setFeature('http://xml.org/sax/features/namespaces', false)
		 def rss_wikipedia = new XmlSlurper(parser).parseText(xml_wikipedia)
		 def d = rss_wikipedia.depthFirst()
		 while (d.hasNext()) {
		 def next = d.next();
		 }
		 //print rss_wikipedia.html.body
		 def htmlTag = rss_wikipedia.body.DIV.find {
		 println "-> $it"
		 it['@id'] == "content"
		 }
		 println "Contenido " + htmlTag
		 */
		//.html.body.content.bodyContent.mw-content-ltr
    }
}
