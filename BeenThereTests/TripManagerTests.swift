import XCTest
@testable import BeenThere

final class TripManagerTests: XCTestCase {
    var tripManager: TripManager!
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "recorded_trips_key")
        tripManager = TripManager()
    }
    
    func testAddTrip() {
        let city1 = City(id: "1", name: "Mumbai", state: "Maharashtra", latitude: 19.076, longitude: 72.877)
        let city2 = City(id: "2", name: "Pune", state: "Maharashtra", latitude: 18.520, longitude: 73.856)
        let trip = Trip(origin: city1, destination: city2, transportMode: .car, date: Date())
        
        tripManager.addTrip(trip)
        
        XCTAssertEqual(tripManager.trips.count, 1)
        XCTAssertEqual(tripManager.trips.first?.origin.name, "Mumbai")
    }
    
    func testDeleteTrip() {
        let city1 = City(id: "1", name: "Mumbai", state: "Maharashtra", latitude: 19.076, longitude: 72.877)
        let city2 = City(id: "2", name: "Pune", state: "Maharashtra", latitude: 18.520, longitude: 73.856)
        let trip = Trip(origin: city1, destination: city2, transportMode: .car, date: Date())
        
        tripManager.addTrip(trip)
        XCTAssertEqual(tripManager.trips.count, 1)
        
        tripManager.deleteTrip(trip)
        XCTAssertEqual(tripManager.trips.count, 0)
    }
    
    func testTripSorting() {
        let city1 = City(id: "1", name: "Mumbai", state: "Maharashtra", latitude: 19.076, longitude: 72.877)
        let city2 = City(id: "2", name: "Pune", state: "Maharashtra", latitude: 18.520, longitude: 73.856)
        
        let oldDate = Date().addingTimeInterval(-3600)
        let newDate = Date()
        
        let oldTrip = Trip(origin: city1, destination: city2, transportMode: .car, date: oldDate)
        let newTrip = Trip(origin: city2, destination: city1, transportMode: .plane, date: newDate)
        
        tripManager.addTrip(oldTrip)
        tripManager.addTrip(newTrip)
        
        XCTAssertEqual(tripManager.trips.first?.id, newTrip.id)
    }
    
    func testTripWithStops() {
        let city1 = City(id: "1", name: "Mumbai", state: "Maharashtra", latitude: 19.076, longitude: 72.877)
        let city2 = City(id: "2", name: "Pune", state: "Maharashtra", latitude: 18.520, longitude: 73.856)
        let city3 = City(id: "3", name: "Satara", state: "Maharashtra", latitude: 17.680, longitude: 73.991)
        
        let trip = Trip(origin: city1, stops: [city2], destination: city3, transportMode: .car, date: Date())
        tripManager.addTrip(trip)
        
        XCTAssertEqual(tripManager.trips.count, 1)
        XCTAssertEqual(tripManager.trips.first?.stops.count, 1)
        XCTAssertEqual(tripManager.trips.first?.stops.first?.name, "Pune")
    }
    
    func testUpdateTrip() {
        let city1 = City(id: "1", name: "Mumbai", state: "Maharashtra", latitude: 19.076, longitude: 72.877)
        let city2 = City(id: "2", name: "Pune", state: "Maharashtra", latitude: 18.520, longitude: 73.856)
        var trip = Trip(origin: city1, destination: city2, transportMode: .car, date: Date())
        tripManager.addTrip(trip)
        
        let newCity2 = City(id: "3", name: "Satara", state: "Maharashtra", latitude: 17.680, longitude: 73.991)
        trip = Trip(id: trip.id, origin: city1, stops: [], destination: newCity2, transportMode: .plane, date: trip.date)
        
        tripManager.updateTrip(trip)
        
        XCTAssertEqual(tripManager.trips.count, 1)
        XCTAssertEqual(tripManager.trips.first?.destination.name, "Satara")
        XCTAssertEqual(tripManager.trips.first?.transportMode, .plane)
    }
}
