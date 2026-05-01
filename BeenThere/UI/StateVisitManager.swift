import Foundation

class StateVisitManager: ObservableObject {
    @Published var visitedStates: Set<String> = []
    
    init() {
        // Pre-fill some states as visited for testing
        visitedStates = ["Maharashtra", "Karnataka", "Goa", "Rajasthan", "Delhi"]
    }
    
    func isVisited(_ stateName: String) -> Bool {
        return visitedStates.contains(stateName)
    }
    
    func toggleVisit(for stateName: String) {
        if visitedStates.contains(stateName) {
            visitedStates.remove(stateName)
        } else {
            visitedStates.insert(stateName)
        }
    }
}
