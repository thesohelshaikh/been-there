import SwiftUI

struct TripsDetailedSummaryView: View {
    @ObservedObject var viewModel: TripsSummaryViewModel
    
    var body: some View {
        List {
            Section(header: Text("Overview")) {
                DetailRow(label: "Total Trips", value: "\(viewModel.totalTrips)")
                DetailRow(label: "Total Distance", value: String(format: "%.0f km", viewModel.totalKilometers))
                DetailRow(label: "Average Trip Length", value: String(format: "%.0f km", viewModel.averageTripLength))
                DetailRow(label: "States Visited", value: "\(viewModel.totalStates)")
                DetailRow(label: "Cities Visited", value: "\(viewModel.totalCities)")
            }
            
            Section(header: Text("States Visited (\(viewModel.visitedStates.count))")) {
                if viewModel.visitedStates.isEmpty {
                    Text("No states visited yet.")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(viewModel.visitedStates, id: \.self) { state in
                        Text(state)
                    }
                }
            }
            
            Section(header: Text("Cities Visited (\(viewModel.visitedCities.count))")) {
                if viewModel.visitedCities.isEmpty {
                    Text("No cities visited yet.")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(viewModel.visitedCities) { city in
                        VStack(alignment: .leading) {
                            Text(city.name)
                                .font(.headline)
                            Text(city.state)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle("Travel Summary")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
                .fontWeight(.bold)
        }
    }
}
