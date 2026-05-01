package com.thesohelshaikh.com.beenthere.ui

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.thesohelshaikh.com.beenthere.domain.IndiaState

@Composable
fun CitySelectionDialog(
    states: List<IndiaState>,
    onCitySelected: (String) -> Unit,
    onDismiss: () -> Unit
) {
    AlertDialog(
        onDismissRequest = onDismiss,
        title = { Text("Mark City as Visited") },
        text = {
            LazyColumn {
                items(states) { state ->
                    ListItem(
                        headlineContent = { Text(state.capital) },
                        supportingContent = { Text(state.name) },
                        modifier = Modifier.clickable {
                            onCitySelected(state.capital)
                            onDismiss()
                        }
                    )
                }
            }
        },
        confirmButton = {
            TextButton(onClick = onDismiss) {
                Text("Cancel")
            }
        }
    )
}
