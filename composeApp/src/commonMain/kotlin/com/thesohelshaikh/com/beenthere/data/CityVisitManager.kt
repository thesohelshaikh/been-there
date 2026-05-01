package com.thesohelshaikh.com.beenthere.data

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow

class CityVisitManager {
    private val _visitedCities = MutableStateFlow<Set<String>>(emptySet())
    val visitedCities: StateFlow<Set<String>> = _visitedCities.asStateFlow()

    fun markCityAsVisited(id: String) {
        val next = _visitedCities.value.toMutableSet()
        if (next.add(id)) {
            _visitedCities.value = next
        }
    }

    fun removeCityVisit(id: String) {
        val next = _visitedCities.value.toMutableSet()
        if (next.remove(id)) {
            _visitedCities.value = next
        }
    }
}
