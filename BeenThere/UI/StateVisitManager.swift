import Foundation
import Combine

class StateVisitManager: ObservableObject {
    @Published var visitedStates: Set<String> = []
    
    private let cityVisitManager: CityVisitManager
    private var cancellables = Set<AnyCancellable>()
    
    init(cityVisitManager: CityVisitManager) {
        self.cityVisitManager = cityVisitManager
        
        // Observe changes in cityVisitManager to update visitedStates
        cityVisitManager.$visitedCities
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateVisitedStates()
            }
            .store(in: &cancellables)
            
        updateVisitedStates()
    }
    
    func isVisited(_ stateName: String) -> Bool {
        visitedStates.contains(stateName)
    }
    
    private func updateVisitedStates() {
        let capitals = CapitalManager.shared.allCapitals()
        var newVisitedStates: Set<String> = []
        
        for (state, capital) in capitals {
            if cityVisitManager.isVisited(cityName: capital, stateName: state) {
                newVisitedStates.insert(state)
            }
        }
        
        // Handle UTs or entities without explicit capitals if needed
        // (currently following "Capital Only" rule as per user instruction)
        
        if self.visitedStates != newVisitedStates {
            self.visitedStates = newVisitedStates
        }
    }
}
