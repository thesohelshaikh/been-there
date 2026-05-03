import XCTest
import CoreLocation
@testable import BeenThere

final class TripsSummaryViewModelTests: XCTestCase {
    var tripManager: TripManager!
    var cityVisitManager: CityVisitManager!
    var stateVisitManager: StateVisitManager!
    var viewModel: TripsSummaryViewModel!
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "recorded_trips_key")
        UserDefaults.standard.removeObject(forKey: "visited_cities_key")
        
        tripManager = TripManager()
        cityVisitManager = CityVisitManager()
        stateVisitManager = StateVisitManager(cityVisitManager: cityVisitManager)
        
        viewModel = TripsSummaryViewModel(
            tripManager: tripManager,
            cityVisitManager: cityVisitManager,
            stateVisitManager: stateVisitManager
        )
    }
    
    func testInitialState() {
        XCTAssertEqual(viewModel.totalStates, 0)
        XCTAssertEqual(viewModel.totalCities, 0)
        XCTAssertEqual(viewModel.totalTrips, 0)
        XCTAssertEqual(viewModel.totalKilometers, 0)
        XCTAssertEqual(viewModel.averageTripLength, 0)
    }
    
    func testStatisticsCalculation() {
        // Mock cities
        let mumbai = City(id: "mumbai", name: "Mumbai", state: "Maharashtra", latitude: 19.076, longitude: 72.877)
        let pune = City(id: "pune", name: "Pune", state: "Maharashtra", latitude: 18.520, longitude: 73.856)
        
        // Mark Mumbai/Pune as visited in cityVisitManager should NOT affect the view model anymore
        cityVisitManager.visitedCities.insert(mumbai)
        
        // Add a trip
        let trip = Trip(origin: mumbai, destination: pune, transportMode: .car, date: Date())
        tripManager.addTrip(trip)
        
        // Distance between Mumbai and Pune is roughly 120-150km.
        let loc1 = CLLocation(latitude: mumbai.latitude, longitude: mumbai.longitude)
        let loc2 = CLLocation(latitude: pune.latitude, longitude: pune.longitude)
        let expectedDistance = loc1.distance(from: loc2) / 1000
        
        viewModel.updateStatistics()
        
        // Total cities should be 2 (Mumbai and Pune from the trip), even though only Mumbai was in cityVisitManager
        XCTAssertEqual(viewModel.totalCities, 2)
        XCTAssertEqual(viewModel.totalStates, 1) // Both in Maharashtra
        XCTAssertEqual(viewModel.totalTrips, 1)
        XCTAssertEqual(viewModel.totalKilometers, expectedDistance, accuracy: 0.1)
        XCTAssertEqual(viewModel.averageTripLength, expectedDistance, accuracy: 0.1)
    }
    
    func testVisitedLists() {
        let mumbai = City(id: "mumbai", name: "Mumbai", state: "Maharashtra", latitude: 19.076, longitude: 72.877)
        let bangalore = City(id: "bangalore", name: "Bangalore", state: "Karnataka", latitude: 12.971, longitude: 77.594)
        
        let trip = Trip(origin: mumbai, destination: bangalore, transportMode: .plane, date: Date())
        tripManager.addTrip(trip)
        
        viewModel.updateStatistics()
        
        XCTAssertEqual(viewModel.visitedCities.count, 2)
        XCTAssertTrue(viewModel.visitedCities.contains(where: { $0.name == "Mumbai" }))
        XCTAssertTrue(viewModel.visitedCities.contains(where: { $0.name == "Bangalore" }))
        
        XCTAssertEqual(viewModel.visitedStates.count, 2)
        XCTAssertTrue(viewModel.visitedStates.contains("Maharashtra"))
        XCTAssertTrue(viewModel.visitedStates.contains("Karnataka"))
    }
    
    func testAverageTripLength() {
        let city1 = City(id: "1", name: "A", state: "S1", latitude: 0, longitude: 0)
        let city2 = City(id: "2", name: "B", state: "S1", latitude: 1, longitude: 1) // Approx 157km
        let city3 = City(id: "3", name: "C", state: "S1", latitude: 2, longitude: 2) // Approx 157km from city2
        
        let trip1 = Trip(origin: city1, destination: city2, transportMode: .car, date: Date())
        let trip2 = Trip(origin: city2, destination: city3, transportMode: .car, date: Date())
        
        tripManager.addTrip(trip1)
        tripManager.addTrip(trip2)
        
        viewModel.updateStatistics()
        
        XCTAssertEqual(viewModel.totalTrips, 2)
        XCTAssertEqual(viewModel.averageTripLength, viewModel.totalKilometers / 2, accuracy: 0.1)
    }
}
