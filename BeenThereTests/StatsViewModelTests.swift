import XCTest
@testable import BeenThere

final class StatsViewModelTests: XCTestCase {
    var cityVisitManager: CityVisitManager!
    var stateVisitManager: StateVisitManager!
    var viewModel: StatsViewModel!
    
    override func setUp() {
        super.setUp()
        // Clear UserDefaults for testing
        UserDefaults.standard.removeObject(forKey: "visited_cities_key")
        UserDefaults.standard.removeObject(forKey: "visited_states_key")
        
        cityVisitManager = CityVisitManager()
        stateVisitManager = StateVisitManager(cityVisitManager: cityVisitManager)
        viewModel = StatsViewModel(stateVisitManager: stateVisitManager)
    }
    
    func testInitialStats() {
        // Migration might add default cities, so let's clear it for a clean test
        cityVisitManager.visitedCities = []
        
        XCTAssertEqual(viewModel.visitedEntitiesCount, 0)
        XCTAssertEqual(viewModel.coveragePercentage, 0)
    }
    
    func testCoverageCalculation() {
        cityVisitManager.visitedCities = []
        
        let mumbai = City(id: "Mumbai-Maharashtra", name: "Mumbai", state: "Maharashtra", latitude: 19.076, longitude: 72.877, isCapital: true)
        let bengaluru = City(id: "Bengaluru-Karnataka", name: "Bengaluru", state: "Karnataka", latitude: 12.971, longitude: 77.594, isCapital: true)
        
        cityVisitManager.toggleVisit(for: mumbai)
        cityVisitManager.toggleVisit(for: bengaluru)
        
        // Wait a bit for Combine to propagate
        let expectation = XCTestExpectation(description: "State update")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.visitedEntitiesCount, 2)
            XCTAssertEqual(self.viewModel.coveragePercentage, 2.0 / 36.0, accuracy: 0.001)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testRegionalStats() {
        cityVisitManager.visitedCities = []
        let centralStats = viewModel.stats(for: .central)
        XCTAssertEqual(centralStats.visited, 0)
        
        let bhopal = City(id: "Bhopal-Madhya Pradesh", name: "Bhopal", state: "Madhya Pradesh", latitude: 23.259, longitude: 77.412, isCapital: true)
        cityVisitManager.toggleVisit(for: bhopal)
        
        let expectation = XCTestExpectation(description: "Regional update")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let updatedStats = self.viewModel.stats(for: .central)
            XCTAssertEqual(updatedStats.visited, 1)
            XCTAssertEqual(updatedStats.percentage, 50) // 1 of 2
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
}
