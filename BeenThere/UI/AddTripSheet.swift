import SwiftUI
import MapKit

struct AddTripSheet: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var tripManager: TripManager
    var tripToEdit: Trip?
    
    @State private var transportMode: TransportMode = .car
    @State private var tripDate = Date()
    @State private var stops: [City] = []
    
    @State private var selectedOrigin: City?
    @State private var selectedDestination: City?
    
    @State private var searchType: SearchType?
    @State private var showingSearch = false
    
    enum SearchType: Identifiable {
        case origin, destination, stop
        var id: Int { hashValue }
    }
    
    init(tripManager: TripManager, tripToEdit: Trip? = nil) {
        self.tripManager = tripManager
        self.tripToEdit = tripToEdit
        
        if let trip = tripToEdit {
            _transportMode = State(initialValue: trip.transportMode)
            _tripDate = State(initialValue: trip.date)
            _stops = State(initialValue: trip.stops)
            _selectedOrigin = State(initialValue: trip.origin)
            _selectedDestination = State(initialValue: trip.destination)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Route") {
                    LocationButton(title: "Origin", city: selectedOrigin) {
                        searchType = .origin
                        showingSearch = true
                    }
                    
                    LocationButton(title: "Destination", city: selectedDestination) {
                        searchType = .destination
                        showingSearch = true
                    }
                }
                
                Section("Intermediate Stops") {
                    ForEach(stops) { stop in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(stop.name)
                                    .font(.subheadline)
                                Text(stop.state)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Button(role: .destructive) {
                                withAnimation {
                                    stops.removeAll { $0.id == stop.id }
                                }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                    Button(action: {
                        searchType = .stop
                        showingSearch = true
                    }) {
                        Label("Add Stop", systemImage: "plus.circle.fill")
                    }
                }
                
                Section("Details") {
                    Picker("Transport Mode", selection: $transportMode) {
                        ForEach(TransportMode.allCases) { mode in
                            Label(mode.displayName, systemImage: mode.iconName).tag(mode)
                        }
                    }
                    
                    DatePicker("Date", selection: $tripDate)
                }
            }
            .navigationTitle(tripToEdit == nil ? "Add Trip" : "Edit Trip")
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button(tripToEdit == nil ? "Add" : "Save") {
                    saveTrip()
                }
                .disabled(selectedOrigin == nil || selectedDestination == nil)
            )
            .sheet(isPresented: $showingSearch) {
                CitySearchView { city in
                    handleCitySelection(city)
                }
            }
        }
    }
    
    private func handleCitySelection(_ city: City) {
        guard let type = searchType else { return }
        switch type {
        case .origin: selectedOrigin = city
        case .destination: selectedDestination = city
        case .stop: stops.append(city)
        }
        searchType = nil
    }
    
    private func saveTrip() {
        guard let origin = selectedOrigin, let destination = selectedDestination else { return }
        
        if let tripToEdit = tripToEdit {
            let updatedTrip = Trip(id: tripToEdit.id, origin: origin, stops: stops, destination: destination, transportMode: transportMode, date: tripDate)
            tripManager.updateTrip(updatedTrip)
        } else {
            let trip = Trip(origin: origin, stops: stops, destination: destination, transportMode: transportMode, date: tripDate)
            tripManager.addTrip(trip)
        }
        
        dismiss()
    }
}

struct LocationButton: View {
    let title: String
    let city: City?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(.primary)
                Spacer()
                if let city = city {
                    Text("\(city.name), \(city.state)")
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                } else {
                    Text("Select City")
                        .foregroundColor(.accentColor)
                }
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
