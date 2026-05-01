package com.thesohelshaikh.com.beenthere.domain

import kotlin.test.Test
import kotlin.test.assertFalse
import kotlin.test.assertTrue

class StateVisitLogicTest {
    private val logic = StateVisitLogic()
    private val maharashtra = IndiaState(
        id = "maharashtra",
        name = "Maharashtra",
        capital = "Mumbai",
        pathData = "M 0 0 L 10 10 Z"
    )

    @Test
    fun shouldReturnTrueWhenCapitalIsVisited() {
        val visitedCities = setOf("Mumbai", "Pune")
        assertTrue(logic.isStateVisited(maharashtra, visitedCities))
    }

    @Test
    fun shouldReturnFalseWhenCapitalIsNotVisited() {
        val visitedCities = setOf("Pune", "Nagpur")
        assertFalse(logic.isStateVisited(maharashtra, visitedCities))
    }

    @Test
    fun shouldReturnFalseWhenNoCitiesVisited() {
        val visitedCities = emptySet<String>()
        assertFalse(logic.isStateVisited(maharashtra, visitedCities))
    }
}
