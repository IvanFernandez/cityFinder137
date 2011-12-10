package com.hopcroft.grails.cityfinder.domain

class Event {
	String id
	String title
	String start
	String end
	Boolean allDay
	String html
	String latitude
	String longitude
	String url
	String photo_url
	String description
    static constraints = {
    }
}
