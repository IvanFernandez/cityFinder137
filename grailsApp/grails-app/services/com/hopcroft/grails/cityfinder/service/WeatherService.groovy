package com.hopcroft.grails.cityfinder.service

class WeatherService {

	static transactional = true

	def String getCityWeatherCode(String woeid) {
		def yahooWeather = "http://weather.yahooapis.com/forecastrss?w=" + woeid + "&u=c"
		def yahooWeatherXML = yahooWeather.toURL().text
		def yrss = new XmlSlurper().parseText(yahooWeatherXML)
		def urlcode = yrss.channel.link.text()
		def list = urlcode.tokenize("//")
		if (list.size() > 0) {
			def dirtyCode = list.last()
			def code = dirtyCode.tokenize("_").first()
		}
		else {
			def code = ""
		}
	}
}
