import Foundation
import CoreLocation
import MapKit

struct City: Codable, Hashable, Identifiable {
    let id: String // e.g., "Mumbai-Maharashtra"
    let name: String
    let state: String
    let latitude: Double
    let longitude: Double
    var isCapital: Bool = false
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

class CityVisitManager: ObservableObject {
    @Published var visitedCities: Set<City> = [] {
        didSet {
            save()
        }
    }
    
    private let storageKey = "visited_cities_key"
    private let legacyStatesKey = "visited_states_key"
    
    init() {
        load()
        migrateIfNeeded()
    }
    
    func isVisited(cityName: String, stateName: String) -> Bool {
        visitedCities.contains { $0.name == cityName && $0.state == stateName }
    }
    
    func toggleVisit(for city: City) {
        if visitedCities.contains(city) {
            visitedCities.remove(city)
        } else {
            visitedCities.insert(city)
        }
    }
    
    func visitedCities(in state: String) -> [City] {
        visitedCities.filter { $0.state == state }.sorted { $0.name < $1.name }
    }
    
    func exportData() -> Data? {
        try? JSONEncoder().encode(Array(visitedCities))
    }
    
    func importData(from data: Data) -> Bool {
        guard let array = try? JSONDecoder().decode([City].self, from: data) else {
            return false
        }
        visitedCities = Set(array)
        return true
    }
    
    func searchAndMarkCity(name: String, state: String, isCapital: Bool = false, completion: ((Bool) -> Void)? = nil) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "\(name), \(state), India"
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let coordinate = response?.mapItems.first?.placemark.coordinate else {
                completion?(false)
                return
            }
            
            let city = City(
                id: "\(name)-\(state)",
                name: name,
                state: state,
                latitude: coordinate.latitude,
                longitude: coordinate.longitude,
                isCapital: isCapital
            )
            
            DispatchQueue.main.async {
                self.visitedCities.insert(city)
                completion?(true)
            }
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(visitedCities) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    private func load() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode(Set<City>.self, from: data) {
            visitedCities = decoded
        }
    }
    
    private func migrateIfNeeded() {
        guard let legacyStates = UserDefaults.standard.stringArray(forKey: legacyStatesKey),
              !legacyStates.isEmpty else {
            return
        }
        
        let capitals = CapitalManager.shared.allCapitals()
        
        for stateName in legacyStates {
            if let capitalName = capitals[stateName] {
                searchAndMarkCity(name: capitalName, state: stateName, isCapital: true)
            }
        }
        
        UserDefaults.standard.removeObject(forKey: legacyStatesKey)
    }
}

class CapitalManager {
    static let shared = CapitalManager()
    private var stateToCapital: [String: String] = [:]
    
    init() {
        loadCapitals()
    }
    
    func capital(for state: String) -> String? {
        stateToCapital[state]
    }
    
    func allCapitals() -> [String: String] {
        stateToCapital
    }
    
    private func loadCapitals() {
        guard let url = Bundle.main.url(forResource: "india_states", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else {
            return
        }
        
        for item in json {
            if let name = item["name"] as? String,
               let capital = item["capital"] as? String,
               !capital.isEmpty {
                stateToCapital[name] = capital
            }
        }
    }
}
