package com.thesohelshaikh.com.beenthere.ui

import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Rect
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.graphics.drawscope.scale
import androidx.compose.ui.graphics.drawscope.withTransform
import androidx.compose.ui.graphics.vector.PathParser
import com.thesohelshaikh.com.beenthere.domain.StateWithVisitStatus
import kotlin.math.max
import kotlin.math.min

@Composable
fun IndiaMap(
    states: List<StateWithVisitStatus>,
    modifier: Modifier = Modifier
) {
    if (states.isEmpty()) return

    Canvas(modifier = modifier.fillMaxSize().background(Color.White)) {
        val parsedPaths = states.map { it to PathParser().parsePathString(it.state.pathData).toPath() }
        
        // Calculate total bounding box manually to avoid union conflict
        var minX = Float.POSITIVE_INFINITY
        var minY = Float.POSITIVE_INFINITY
        var maxX = Float.NEGATIVE_INFINITY
        var maxY = Float.NEGATIVE_INFINITY

        parsedPaths.forEach { (_, path) ->
            val b = path.getBounds()
            minX = min(minX, b.left)
            minY = min(minY, b.top)
            maxX = max(maxX, b.right)
            maxY = max(maxY, b.bottom)
        }

        if (minX != Float.POSITIVE_INFINITY) {
            val mapWidth = maxX - minX
            val mapHeight = maxY - minY
            
            val scaleX = size.width / mapWidth
            val scaleY = size.height / mapHeight
            val scale = minOf(scaleX, scaleY) * 0.9f // 90% of screen to have margins

            withTransform({
                // Center the map
                translate(
                    left = (size.width - mapWidth * scale) / 2f - minX * scale,
                    top = (size.height - mapHeight * scale) / 2f - minY * scale
                )
                scale(scale, scale, pivot = androidx.compose.ui.geometry.Offset.Zero)
            }) {
                parsedPaths.forEach { (stateWithStatus, path) ->
                    drawPath(
                        path = path,
                        color = if (stateWithStatus.isVisited) Color(0xFF4CAF50) else Color(0xFFCCCCCC)
                    )
                    
                    drawPath(
                        path = path,
                        color = Color.DarkGray,
                        style = Stroke(width = 1f / scale)
                    )
                }
            }
        }
    }
}
