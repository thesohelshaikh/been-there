import Foundation
import Combine
import SwiftUI
import CoreLocation

class TripsSummaryViewModel: ObservableObject {
    @Published var totalStates: Int = 0
    @Published var totalCities: Int = 0
    @Published var totalTrips: Int = 0
    @Published var totalKilometers: Double = 0
    @Published var averageTripLength: Double = 0
    @Published var visitedCities: [City] = []
    @Published var visitedStates: [String] = []

    private var tripManager: TripManager
    private var cityVisitManager: CityVisitManager
    private var stateVisitManager: StateVisitManager
    private var cancellables = Set<AnyCancellable>()

    init(tripManager: TripManager, cityVisitManager: CityVisitManager, stateVisitManager: StateVisitManager) {
        self.tripManager = tripManager
        self.cityVisitManager = cityVisitManager
        self.stateVisitManager = stateVisitManager
        
        bind()
        updateStatistics()
    }

    private func bind() {
        tripManager.$trips
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateStatistics()
            }
            .store(in: &cancellables)

        cityVisitManager.$visitedCities
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateStatistics()
            }
            .store(in: &cancellables)

        stateVisitManager.$visitedStates
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateStatistics()
            }
            .store(in: &cancellables)
    }

    func updateStatistics() {
        var visitedCitySet = Set<City>()
        var visitedStatesSet = Set<String>()
        var totalDistance: CLLocationDistance = 0
        
        for trip in tripManager.trips {
            let locations = [trip.origin] + trip.stops + [trip.destination]
            var lastLocation: CLLocation?
            
            for city in locations {
                visitedCitySet.insert(city)
                visitedStatesSet.insert(city.state)
                
                let currentLocation = CLLocation(latitude: city.latitude, longitude: city.longitude)
                if let lastLocation = lastLocation {
                    totalDistance += currentLocation.distance(from: lastLocation)
                }
                lastLocation = currentLocation
            }
        }
        
        totalStates = visitedStatesSet.count
        totalCities = visitedCitySet.count
        totalTrips = tripManager.trips.count
        totalKilometers = totalDistance / 1000
        
        visitedCities = Array(visitedCitySet).sorted { $0.name < $1.name }
        visitedStates = Array(visitedStatesSet).sorted { $0 < $1 }
        
        if totalTrips > 0 {
            averageTripLength = totalKilometers / Double(totalTrips)
        } else {
            averageTripLength = 0
        }
    }
}
