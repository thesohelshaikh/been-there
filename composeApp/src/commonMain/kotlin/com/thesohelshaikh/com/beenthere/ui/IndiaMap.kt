package com.thesohelshaikh.com.beenthere.ui

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import beenthere.composeapp.generated.resources.Res
import io.github.dellisd.spatialk.geojson.Position
import org.jetbrains.compose.resources.ExperimentalResourceApi
import org.maplibre.compose.camera.rememberCameraState
import org.maplibre.compose.camera.CameraPosition
import org.maplibre.compose.style.BaseStyle
import org.maplibre.compose.expressions.dsl.*
import org.maplibre.compose.layers.FillLayer
import org.maplibre.compose.layers.LineLayer
import org.maplibre.compose.map.MaplibreMap
import org.maplibre.compose.sources.GeoJsonData
import org.maplibre.compose.sources.rememberGeoJsonSource

@OptIn(ExperimentalResourceApi::class)
@Composable
fun IndiaMap(
    visitedStateNames: Set<String>,
    modifier: Modifier = Modifier
) {
    var geoJsonString by remember { mutableStateOf<String?>(null) }
    
    // Map of repository state names to GeoJSON ST_NM property values
    val geoJsonNameMap = remember {
        mapOf(
            "Arunachal Pradesh" to "Arunanchal Pradesh",
            "Telangana" to "Telengana",
            "Andaman and Nicobar Islands" to "Andaman & Nicobar Island",
            "Dadra and Nagar Haveli" to "Dadara & Nagar Haveli",
            "Daman and Diu" to "Daman & Diu",
            "Jammu and Kashmir" to "Jammu & Kashmir",
            "NCT of Delhi" to "Delhi"
        )
    }

    val mappedVisitedNames = remember(visitedStateNames) {
        visitedStateNames.map { geoJsonNameMap[it] ?: it }.toSet()
    }

    LaunchedEffect(Unit) {
        try {
            val bytes = Res.readBytes("files/india_states.geojson")
            geoJsonString = bytes.decodeToString()
        } catch (e: Exception) {
            println("IndiaMap: Error loading GeoJSON: ${e.message}")
        }
    }

    if (geoJsonString == null) return

    val cameraState = rememberCameraState(
        firstPosition = CameraPosition(
            target = Position(78.9629, 20.5937),
            zoom = 3.5
        )
    )

    MaplibreMap(
        modifier = modifier.fillMaxSize(),
        baseStyle = BaseStyle.Uri("https://demotiles.maplibre.org/style.json"),
        cameraState = cameraState
    ) {
        val indiaSource = rememberGeoJsonSource(
            data = GeoJsonData.JsonString(geoJsonString!!)
        )

        FillLayer(
            id = "states-fill",
            source = indiaSource,
            color = if (mappedVisitedNames.isEmpty()) {
                const(Color(0xFFCCCCCC).copy(alpha = 0.5f))
            } else {
                switch(
                    input = feature.get("ST_NM").asString(),
                    cases = mappedVisitedNames.map { case(it, const(Color(0xFF4CAF50))) }.toTypedArray(),
                    fallback = const(Color(0xFFCCCCCC).copy(alpha = 0.5f))
                )
            },
            opacity = const(0.7f)
        )

        LineLayer(
            id = "states-outline",
            source = indiaSource,
            color = const(Color.DarkGray),
            width = const(1.dp)
        )
    }
}
