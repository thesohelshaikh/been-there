package com.thesohelshaikh.com.beenthere.domain

import com.thesohelshaikh.com.beenthere.data.CityVisitManager
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.flow
import kotlinx.serialization.json.Json
import org.jetbrains.compose.resources.ExperimentalResourceApi
import beenthere.composeapp.generated.resources.Res

data class StateWithVisitStatus(
    val state: IndiaState,
    val isVisited: Boolean
)

class IndiaStateRepository(
    private val cityVisitManager: CityVisitManager,
    private val stateVisitLogic: StateVisitLogic = StateVisitLogic()
) {
    private val json = Json { ignoreUnknownKeys = true }

    @OptIn(ExperimentalResourceApi::class)
    private suspend fun loadStates(): List<IndiaState> {
        println("IndiaStateRepository: Loading states...")
        return try {
            val bytes = Res.readBytes("files/india_states.json")
            val content = bytes.decodeToString()
            val states = json.decodeFromString<List<IndiaState>>(content)
            println("IndiaStateRepository: Loaded ${states.size} states")
            states
        } catch (e: Exception) {
            println("IndiaStateRepository: Error loading states: ${e.message}")
            e.printStackTrace()
            emptyList()
        }
    }

    fun getStatesWithVisitStatus(): Flow<List<StateWithVisitStatus>> = combine(
        flow { emit(loadStates()) },
        cityVisitManager.visitedCities
    ) { states, visitedCities ->
        println("IndiaStateRepository: Combining states with visit status. Visited cities: $visitedCities")
        states.map { state ->
            StateWithVisitStatus(
                state = state,
                isVisited = stateVisitLogic.isStateVisited(state, visitedCities)
            )
        }
    }
}
