import Foundation
import CoreLocation

enum TransportMode: String, Codable, CaseIterable, Identifiable {
    case plane
    case train
    case car
    case bike
    
    var id: String { self.rawValue }
    
    var iconName: String {
        switch self {
        case .plane: return "airplane"
        case .train: return "train.side.front.car"
        case .car: return "car.fill"
        case .bike: return "bicycle"
        }
    }
    
    var displayName: String {
        self.rawValue.capitalized
    }
}

struct Trip: Codable, Identifiable, Hashable {
    var id = UUID()
    let origin: City
    var stops: [City] = []
    let destination: City
    let transportMode: TransportMode
    let date: Date
}

class TripManager: ObservableObject {
    @Published var trips: [Trip] = [] {
        didSet {
            save()
        }
    }
    
    private let storageKey = "recorded_trips_key"
    
    init() {
        load()
    }
    
    func addTrip(_ trip: Trip) {
        trips.append(trip)
        trips.sort { $0.date > $1.date }
    }
    
    func updateTrip(_ trip: Trip) {
        if let index = trips.firstIndex(where: { $0.id == trip.id }) {
            trips[index] = trip
            trips.sort { $0.date > $1.date }
        }
    }
    
    func deleteTrip(at offsets: IndexSet) {
        trips.remove(atOffsets: offsets)
    }
    
    func deleteTrip(_ trip: Trip) {
        trips.removeAll { $0.id == trip.id }
    }
    
    func clearAllTrips() {
        print("🗑️ Clearing all trips")
        trips = []
    }
    
    private func save() {
        do {
            let encoded = try JSONEncoder().encode(trips)
            UserDefaults.standard.set(encoded, forKey: storageKey)
            print("✅ Successfully saved \(trips.count) trips")
        } catch {
            print("❌ Failed to save trips: \(error.localizedDescription)")
        }
    }
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            print("ℹ️ No saved trips found")
            return
        }
        
        do {
            let decoded = try JSONDecoder().decode([Trip].self, from: data)
            trips = decoded.sorted { $0.date > $1.date }
            print("✅ Successfully loaded \(trips.count) trips")
        } catch {
            print("❌ Failed to load trips: \(error.localizedDescription)")
        }
    }
}
