package com.hopcroft.grails.cityfinder.domain
import grails.converters.JSON
import net.sf.json.groovy.JsonSlurper
import grails.converters.*;
import java.text.SimpleDateFormat

import org.codehaus.groovy.grails.web.json.JSONArray;


class CityController {
	def weatherService
	def locationService
	def newsService
	def eventService
	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

	def info =  {
		def cityInstance = City.get(params.id)
		def encodedCity = URLEncoder.encode(cityInstance.name)

		// Location
		def locationInformation = locationService.getCityInfo(encodedCity)
		def woeid = locationInformation.place.woeid  // size 0 si no se encuentra
		println "woeid.size(): " + woeid.size()
		if (woeid.size() > 0) {
			flash.latitude = locationInformation.place.centroid.latitude
			flash.longitude = locationInformation.place.centroid.longitude
			// Yahoo Weather
			def weatherCode = weatherService.getCityWeatherCode(woeid.toString()); // vacio si error

			//Google News.
			def googleNews = newsService.getGoogleNews(encodedCity) // size = 0 si error

			//Yahoo and eventful events.
			def List<Event> events = eventService.getYahooEvents(woeid.toString(), null)
			events += eventService.getEventfulEvents(encodedCity, null)
			def jsonEvents = events as JSON
			flash.woeid = woeid
			flash.isEmptyEvents = events.isEmpty()
			flash.events = jsonEvents
			flash.weatherCode = weatherCode
			flash.googleNews = googleNews
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
