package com.hopcroft.grails.cityfinder.domain
//import grails.converters.JSON
import grails.converters.JSON
import net.sf.json.groovy.JsonSlurper
import grails.converters.*;


class CityController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def info =  {
		// Get woeid
		def cityInstance = City.get(params.id)
		println cityInstance
		def cityEncoded = URLEncoder.encode(cityInstance.name)
		//println cityEncoded
		def appid = "foOF4CzV34EFIIW4gz1lx0Ze1em._w1An3QyivRalpXCK9sIXT5de810JWold3ApkdMdCrc-%22"
		def url = "http://where.yahooapis.com/v1/places.q('" + cityEncoded + "')?appid=" + appid;
//		println "URLL " + url
		def xml = url.toURL().text
//		println xml
		def rss = new XmlSlurper().parseText(xml)
		def woeid = rss.place.woeid
		flash.latitude = rss.place.centroid.latitude
		flash.longitude = rss.place.centroid.longitude
		//Yahoo weather.
		def yahooWeather = "http://weather.yahooapis.com/forecastrss?w=" + woeid + "&u=c"
		def yahooWeatherXML = yahooWeather.toURL().text
		def yrss = new XmlSlurper().parseText(yahooWeatherXML)
		def urlcode = yrss.channel.link.text()
		def list = urlcode.tokenize("//")
		//Google News.
		def url_news ='http://news.google.com/news?q=' + cityEncoded + '&output=rss'
		//println "URL_NEWS " + url_news
		def xml_news = url_news.toURL().text
		def rss_news = new XmlSlurper().parseText(xml_news)
		//println rss_news.rss.channel
		def lnews = []
		rss_news.channel.item.each {
			println "Titulo del item: " + it.title
			lnews << it
		}
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
		
		//Yahoo events.
		def yahoo_events_url = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20upcoming.events%20where%20woeid%20in%20(" + woeid + ")%20limit%2020&format=json"
		def yahoo_events_text = yahoo_events_url.toURL().text
		def yahoo_events = new JsonSlurper().parseText(yahoo_events_text)
		List<Event> events = new ArrayList<Event>()
		
//		List parsedList = JSON.(yahoo_events_text) as List
//		Event evt = new Event()
//		bindData(evt, parsedList[0]);
//		print "EVT: " + evt
		
		yahoo_events.query.results.event.each {
			Event event = new Event()
			//TODO: hacer un html más estético
			event.html = it.name + '\n'
//			event.html += "<img src=\"" + it.photo_url + "\"/>"
			event.latitude = it.latitude
			event.longitude = it.longitude
			events << event
//			println "Event: " + event.html 
		}
		
//		println "Eventful"
		// eventos de eventful
		def url_eventful = "http://api.eventful.com/rest/events/search?app_key=gGZgS7gdjk2nnXKr&location=" + cityEncoded + "&date=Future&page_size=50"
		def url_eventful_text = url_eventful.toURL().text
		//println "url_eventful_text" + url_eventful_text
		def eventful = new XmlSlurper().parseText(url_eventful_text)
//		println "EVFUL" + eventful
		eventful.events.event.each {
//			println it
			Event event = new Event()
			//TODO: hacer un html más estético
			event.html = it.title + '\n'
//			event.html += "<img src=\"" + it.photo_url + "\"/>"
			event.latitude = it.latitude
			event.longitude = it.longitude
			events << event
//			println "Event: " + event.html
		}
		//println "EVENTFUL: " + eventful
//		println " "
//		println "@@@"
//		println " "
//		println "111111111@@@" + eventful.search + "@@@"
//		println " "
//		println "222222222@@@" + eventful.events + "@@@"
//		println " "
		
		
		
		def json_events = (events as JSON).toString()
//		println "Eventos json: " + json_events
//		def mi_json = yahoo_events_text as JSON
		//def y = yahoo_events_text.substring(0, yahoo_events_text.length()-30)
//		def city_events = new XmlSlurper().parseText(yahoo_events_text)
//		println "City events " + city_events + "@@@"
//		println "Diagnostics " + city_events.diagnostics + "@@@"
//		println "Eventos -->"
//		city_events.diagnostics.each {
//			println "Event. " + it
//		}
		


		if (list.size() > 0) {
			def dirtyCode = list.last()
			def code = dirtyCode.tokenize("_").first()
			println code
			flash.events = json_events
			flash.code = code
			flash.lnews = lnews
			flash.wikipedia = xml_wikipedia
			render(view: "info", model: [cityInstance: cityInstance])
			return
		}
		else {
			redirect(action: "list")
		}
	}

	def index = {
		redirect(action: "list", params: params)
	}

	def list = {
		params.max = Math.min(params.max ? params.int('max') : 10, 100)
		[cityInstanceList: City.list(params), cityInstanceTotal: City.count()]
	}

	def create = {
		def cityInstance = new City()
		cityInstance.properties = params
		return [cityInstance: cityInstance]
	}

	def save = {
		def cityInstance = new City(params)
		if (cityInstance.save(flush: true)) {
			flash.message = "${message(code: 'default.created.message', args: [message(code: 'city.label', default: 'City'), cityInstance.id])}"
			redirect(action: "show", id: cityInstance.id)
		}
		else {
			render(view: "create", model: [cityInstance: cityInstance])
		}
	}

	def show = {
		def cityInstance = City.get(params.id)
		if (!cityInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), params.id])}"
			redirect(action: "list")
		}
		else {
			[cityInstance: cityInstance]
		}
	}

	def edit = {
		def cityInstance = City.get(params.id)
		if (!cityInstance) {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), params.id])}"
			redirect(action: "list")
		}
		else {
			return [cityInstance: cityInstance]
		}
	}

	def update = {
		def cityInstance = City.get(params.id)
		if (cityInstance) {
			if (params.version) {
				def version = params.version.toLong()
				if (cityInstance.version > version) {

					cityInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [
						message(code: 'city.label', default: 'City')]
					as Object[], "Another user has updated this City while you were editing")
					render(view: "edit", model: [cityInstance: cityInstance])
					return
				}
			}
			cityInstance.properties = params
			if (!cityInstance.hasErrors() && cityInstance.save(flush: true)) {
				flash.message = "${message(code: 'default.updated.message', args: [message(code: 'city.label', default: 'City'), cityInstance.id])}"
				redirect(action: "show", id: cityInstance.id)
			}
			else {
				render(view: "edit", model: [cityInstance: cityInstance])
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), params.id])}"
			redirect(action: "list")
		}
	}

	def delete = {
		def cityInstance = City.get(params.id)
		if (cityInstance) {
			try {
				cityInstance.delete(flush: true)
				flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'city.label', default: 'City'), params.id])}"
				redirect(action: "list")
			}
			catch (org.springframework.dao.DataIntegrityViolationException e) {
				flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'city.label', default: 'City'), params.id])}"
				redirect(action: "show", id: params.id)
			}
		}
		else {
			flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'city.label', default: 'City'), params.id])}"
			redirect(action: "list")
		}
	}
}
