package com.hopcroft.grails.cityfinder.service

import com.sun.org.apache.bcel.internal.generic.RETURN;

class NewsService {

    static transactional = true

    def List getGoogleNews(String encodedCity) {
		def url_news ='http://news.google.com/news?q=' + encodedCity + '&output=rss'
		def xml_news = url_news.toURL().text
		def rss_news = new XmlSlurper().parseText(xml_news)
		def news = []
		rss_news.channel.item.each {
			news << it
		}
		return news
    }
}
