package com.thesohelshaikh.com.beenthere

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontFamily
import com.thesohelshaikh.com.beenthere.data.CityVisitManager
import com.thesohelshaikh.com.beenthere.domain.IndiaStateRepository
import com.thesohelshaikh.com.beenthere.ui.CitySelectionDialog
import com.thesohelshaikh.com.beenthere.ui.IndiaMap

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun App() {
    val cityVisitManager = remember { CityVisitManager() }
    val repository = remember { IndiaStateRepository(cityVisitManager) }
    
    val statesWithStatus by repository.getStatesWithVisitStatus().collectAsState(initial = null)
    val visitedCities by cityVisitManager.visitedCities.collectAsState()
    var showCityDialog by remember { mutableStateOf(false) }
    
    val typography = Typography(
        bodyLarge = TextStyle(fontFamily = FontFamily.Default),
        bodyMedium = TextStyle(fontFamily = FontFamily.Default),
        bodySmall = TextStyle(fontFamily = FontFamily.Default),
        titleLarge = TextStyle(fontFamily = FontFamily.Default),
        titleMedium = TextStyle(fontFamily = FontFamily.Default),
        titleSmall = TextStyle(fontFamily = FontFamily.Default),
        labelLarge = TextStyle(fontFamily = FontFamily.Default),
        labelMedium = TextStyle(fontFamily = FontFamily.Default),
        labelSmall = TextStyle(fontFamily = FontFamily.Default)
    )

    MaterialTheme(typography = typography) {
        Scaffold(
            topBar = {
                CenterAlignedTopAppBar(
                    title = { Text("Been There - India") }
                )
            },
            floatingActionButton = {
                FloatingActionButton(onClick = { showCityDialog = true }) {
                    Text("+")
                }
            }
        ) { padding ->
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(padding)
            ) {
                val currentStates = statesWithStatus
                if (currentStates == null) {
                    CircularProgressIndicator(modifier = Modifier.align(Alignment.Center))
                } else if (currentStates.isEmpty()) {
                    Text("No states found. Check JSON data.", modifier = Modifier.align(Alignment.Center))
                } else {
                    IndiaMap(
                        visitedStateNames = currentStates.filter { it.isVisited }.map { it.state.name }.toSet(),
                        modifier = Modifier.fillMaxSize()
                    )
                }

                if (showCityDialog && currentStates != null) {
                    CitySelectionDialog(
                        states = currentStates.map { it.state },
                        onCitySelected = { cityId ->
                            cityVisitManager.markCityAsVisited(cityId)
                        },
                        onDismiss = { showCityDialog = false }
                    )
                }
            }
        }
    }
}
