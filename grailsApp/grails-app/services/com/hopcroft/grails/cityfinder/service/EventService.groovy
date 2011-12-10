package com.hopcroft.grails.cityfinder.service

import com.hopcroft.grails.cityfinder.domain.Event
import net.sf.json.groovy.JsonSlurper

class EventService {

	static transactional = true

	def List<Event> getYahooEvents(String woeid, List options) {
		def yahoo_events_url = "http://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20upcoming.events%20where%20woeid%20in%20(" + woeid + ")%20limit%2020&format=json"
		def yahoo_events_text = yahoo_events_url.toURL().text
		def yahoo_events = new JsonSlurper().parseText(yahoo_events_text)
		List<Event> events = new ArrayList<Event>()
		if (yahoo_events.query.count > 0) {
			//TODO: get event id from somewhere else
			yahoo_events.query.results.event.each {
				Event event = new Event()
				//TODO: do a better html dialog
				event.html = it.name + '\n'
				event.latitude = it.latitude
				event.longitude = it.longitude
				events << event
			}
		}
		return events
	}

	def List<Event> getEventfulEvents(String encodedCity, List options) {
		List<Event> events = new ArrayList<Event>()
		// eventos de eventful
//		long id = 0
		def url_eventful = "http://api.eventful.com/rest/events/search?app_key=gGZgS7gdjk2nnXKr&location=" + encodedCity + "&date=Future&page_size=90&sort_order=relevance"
		def url_eventful_text = url_eventful.toURL().text
		def eventful = new XmlSlurper().parseText(url_eventful_text)
		//println "eventful: " +eventful
		eventful.events.event.each {
			Event event = new Event()
			//TODO: hacer un html más estético
			def html = it.title.toString() + " - Venue " + it.venue_name.toString()
			event.html = html
			//			event.html += "<img src=\"" + it.photo_url + "\"/>"
			event.latitude = it.latitude
			event.longitude = it.longitude
			event.title = it.title + " - Venue " + it.venue_name
			//			def com = it.start_time
			//			def comienzo = new Date()
			//			def datee = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(com.toString())
			//			def datte2 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(datee)
			event.start = it.start_time.toString()
			event.end = it.stop_time.toString()
			event.allDay = false
//			event.id = id++
			events << event
		}
		return events
	}
}
