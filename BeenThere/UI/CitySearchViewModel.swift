import Foundation
import MapKit
import Combine

class CitySearchViewModel: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var searchText = ""
    @Published var completions: [MKLocalSearchCompletion] = []
    @Published var isSearching = false
    
    private var completer: MKLocalSearchCompleter
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        self.completer = MKLocalSearchCompleter()
        super.init()
        self.completer.delegate = self
        self.completer.resultTypes = .address
        
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                if text.isEmpty {
                    self?.completions = []
                    self?.isSearching = false
                } else {
                    self?.isSearching = true
                    self?.completer.queryFragment = "\(text), India"
                }
            }
            .store(in: &cancellables)
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.completions = completer.results
            self.isSearching = false
        }
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Search completer failed: \(error.localizedDescription)")
        DispatchQueue.main.async {
            self.isSearching = false
        }
    }
    
    func selectCompletion(_ completion: MKLocalSearchCompletion, completionHandler: @escaping (City?) -> Void) {
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let item = response?.mapItems.first else {
                completionHandler(nil)
                return
            }
            
            let cityName = item.name ?? "Unknown"
            let stateName = item.placemark.administrativeArea ?? "Unknown"
            let coordinate = item.placemark.coordinate
            
            let city = City(
                id: "\(cityName)-\(stateName)-\(coordinate.latitude)-\(coordinate.longitude)",
                name: cityName,
                state: stateName,
                latitude: coordinate.latitude,
                longitude: coordinate.longitude
            )
            
            DispatchQueue.main.async {
                completionHandler(city)
            }
        }
    }
}
