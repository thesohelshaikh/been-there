package com.thesohelshaikh.com.beenthere.domain

import kotlinx.serialization.Serializable
import kotlinx.serialization.SerialName

@Serializable
data class IndiaState(
    val id: String,
    val name: String,
    val capital: String,
    @SerialName("path")
    val pathData: String
)

class StateVisitLogic {
    fun isStateVisited(state: IndiaState, visitedCities: Set<String>): Boolean {
        return visitedCities.contains(state.capital)
    }
}
