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
    
    func exportData() -> Data? {
        cityVisitManager.exportData()
    }
    
    func importData(from data: Data) -> Bool {
        cityVisitManager.importData(from: data)
    }
    
    private func updateVisitedStates() {
        let capitals = CapitalManager.shared.allCapitals()
        var newVisitedStates: Set<String> = []
        
        for (state, capital) in capitals {
            if cityVisitManager.isVisited(cityName: capital, stateName: state) {
                newVisitedStates.insert(state)
            }
        }
        
        if self.visitedStates != newVisitedStates {
            self.visitedStates = newVisitedStates
        }
    }
}
