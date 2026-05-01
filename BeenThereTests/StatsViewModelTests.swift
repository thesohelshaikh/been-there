import XCTest
@testable import BeenThere

final class StatsViewModelTests: XCTestCase {
    var stateVisitManager: StateVisitManager!
    var viewModel: StatsViewModel!
    
    override func setUp() {
        super.setUp()
        stateVisitManager = StateVisitManager()
        stateVisitManager.visitedStates = [] 
        viewModel = StatsViewModel(stateVisitManager: stateVisitManager)
    }
    
    func testInitialStats() {
        XCTAssertEqual(viewModel.visitedEntitiesCount, 0)
        XCTAssertEqual(viewModel.coveragePercentage, 0)
    }
    
    func testCoverageCalculation() {
        stateVisitManager.toggleVisit(for: "Maharashtra")
        stateVisitManager.toggleVisit(for: "Karnataka")
        
        XCTAssertEqual(viewModel.visitedEntitiesCount, 2)
        XCTAssertEqual(viewModel.coveragePercentage, 2.0 / 36.0, accuracy: 0.001)
    }
    
    func testRegionalStats() {
        let centralStats = viewModel.stats(for: .central)
        XCTAssertEqual(centralStats.visited, 0)
        
        stateVisitManager.visitedStates.insert("Madhya Pradesh")
        
        let updatedStats = viewModel.stats(for: .central)
        XCTAssertEqual(updatedStats.visited, 1)
        XCTAssertEqual(updatedStats.percentage, 50) // 1 of 2
    }
}
