import SwiftUI

struct TripsView: View {
    @ObservedObject var tripManager: TripManager
    @State private var showingAddTrip = false
    @State private var tripToEdit: Trip?
    @State private var tripToDelete: Trip?
    @State private var showingDeleteAlert = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tripManager.trips) { trip in
                    TripRow(trip: trip)
                        .swipeActions(edge: .leading) {
                            Button {
                                tripToEdit = trip
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.orange)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                tripToDelete = trip
                                showingDeleteAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .navigationTitle("Road Trips")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { 
                        tripToEdit = nil
                        showingAddTrip = true 
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTrip) {
                AddTripSheet(tripManager: tripManager)
            }
            .sheet(item: $tripToEdit) { trip in
                AddTripSheet(tripManager: tripManager, tripToEdit: trip)
            }
            .alert("Delete Trip", isPresented: $showingDeleteAlert, presenting: tripToDelete) { trip in
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    tripManager.deleteTrip(trip)
                }
            } message: { trip in
                Text("Are you sure you want to delete the trip from \(trip.origin.name) to \(trip.destination.name)?")
            }
            .overlay {
                if tripManager.trips.isEmpty {
                    VStack {
                        Image(systemName: "road.lanes")
                            .font(.system(size: 64))
                            .foregroundColor(.secondary)
                        Text("No trips yet")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        Button("Add Your First Trip") {
                            showingAddTrip = true
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct TripRow: View {
    let trip: Trip
    
    var body: some View {
        HStack {
            Image(systemName: trip.transportMode.iconName)
                .font(.title2)
                .foregroundColor(.accentColor)
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text("\(trip.origin.name) to \(trip.destination.name)")
                    .font(.headline)
                HStack {
                    Text(trip.date.formatted(date: .abbreviated, time: .omitted))
                    if !trip.stops.isEmpty {
                        Text("•")
                        Text("\(trip.stops.count) stop\(trip.stops.count > 1 ? "s" : "")")
                    }
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
