import Foundation

class StateVisitManager: ObservableObject {
    @Published var visitedStates: Set<String> = [] {
        didSet {
            save()
        }
    }
    
    private let storageKey = "visited_states_key"
    
    init() {
        load()
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
    
    private func save() {
        let array = Array(visitedStates)
        UserDefaults.standard.set(array, forKey: storageKey)
    }
    
    private func load() {
        if let array = UserDefaults.standard.stringArray(forKey: storageKey) {
            visitedStates = Set(array)
        } else {
            // Default states for first-time users
            visitedStates = ["Maharashtra", "Karnataka", "Goa", "Rajasthan", "Delhi"]
        }
    }
}
