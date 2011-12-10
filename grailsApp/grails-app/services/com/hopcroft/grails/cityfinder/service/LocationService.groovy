package com.hopcroft.grails.cityfinder.service

import groovy.util.slurpersupport.GPathResult;

class LocationService {

    static transactional = true
	def yahoo_appid = "foOF4CzV34EFIIW4gz1lx0Ze1em._w1An3QyivRalpXCK9sIXT5de810JWold3ApkdMdCrc-%22"
	
    def GPathResult getCityInfo(String encodedCity) {
		def url = "http://where.yahooapis.com/v1/places.q('" + encodedCity + "')?appid=" + yahoo_appid;
		def xml = url.toURL().text
		def rss = new XmlSlurper().parseText(xml)
    }
}
