package com.hopcroft.grails.cityfinder.domain

class City {
	String name
	String country

    static constraints = {
    	name blank : false
    	country blank : false
    }
}
