import SwiftUI
import MapKit

struct CitySelectionSheet: View {
    let stateName: String
    @ObservedObject var cityVisitManager: CityVisitManager
    
    @State private var searchText = ""
    @State private var searchResults: [MKMapItem] = []
    @State private var isSearching = false
    @State private var isAddingCapital = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                let capital = CapitalManager.shared.capital(for: stateName)
                let isCapitalVisited = capital != nil && cityVisitManager.isVisited(cityName: capital!, stateName: stateName)
                
                if let capitalName = capital, !isCapitalVisited {
                    Section(header: Text("State Capital")) {
                        Button(action: { addCapital(capitalName) }) {
                            HStack {
                                Image(systemName: "star.circle.fill")
                                    .foregroundColor(.yellow)
                                Text("Mark \(capitalName) as Visited")
                                Spacer()
                                if isAddingCapital {
                                    ProgressView()
                                } else {
                                    Image(systemName: "plus")
                                        .font(.caption.bold())
                                }
                            }
                        }
                        .disabled(isAddingCapital)
                    }
                }
                
                Section(header: Text("Visited Cities")) {
                    let visited = cityVisitManager.visitedCities(in: stateName)
                    if visited.isEmpty {
                        Text("No cities visited in \(stateName) yet.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(visited) { city in
                            HStack {
                                Text(city.name)
                                Spacer()
                                if city.isCapital {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                        .onDelete { indexSet in
                            deleteCities(at: indexSet, from: visited)
                        }
                    }
                }
                
                if !searchText.isEmpty {
                    Section(header: Text("Search Results")) {
                        if isSearching {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        } else if searchResults.isEmpty {
                            Text("No cities found.")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        } else {
                            ForEach(searchResults, id: \.self) { item in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name ?? "Unknown")
                                            .font(.body)
                                        Text(item.placemark.title ?? "")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    let isVisited = cityVisitManager.isVisited(cityName: item.name ?? "", stateName: stateName)
                                    if isVisited {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                    } else {
                                        Image(systemName: "plus.circle")
                                            .foregroundColor(.accentColor)
                                    }
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    addCity(item)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(stateName)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Search for a city...")
            .onChange(of: searchText) { newValue in
                performSearch()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.primary)
                            .frame(width: 28, height: 28)
                            .background(Color(UIColor.systemGray5))
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
    
    private func performSearch() {
        guard !searchText.isEmpty else {
            searchResults = []
            return
        }
        isSearching = true
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "\(searchText), \(stateName), India"
        request.resultTypes = .address
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            isSearching = false
            if let response = response {
                self.searchResults = response.mapItems.filter { item in
                    let isNotPOI = item.pointOfInterestCategory == nil
                    let title = item.placemark.title ?? ""
                    let matchesState = title.localizedCaseInsensitiveContains(stateName) || 
                                     title.localizedCaseInsensitiveContains("India")
                    
                    return isNotPOI && matchesState
                }
            }
        }
    }
    
    private func addCity(_ item: MKMapItem) {
        guard let name = item.name else { return }
        let coord = item.placemark.coordinate
        
        let isCapital = CapitalManager.shared.capital(for: stateName) == name
        
        let city = City(
            id: "\(name)-\(stateName)",
            name: name,
            state: stateName,
            latitude: coord.latitude,
            longitude: coord.longitude,
            isCapital: isCapital
        )
        
        if !cityVisitManager.isVisited(cityName: name, stateName: stateName) {
            cityVisitManager.toggleVisit(for: city)
        }
        
        searchText = ""
        searchResults = []
    }
    
    private func addCapital(_ name: String) {
        isAddingCapital = true
        cityVisitManager.searchAndMarkCity(name: name, state: stateName, isCapital: true) { success in
            isAddingCapital = false
        }
    }
    
    private func deleteCities(at offsets: IndexSet, from cities: [City]) {
        for index in offsets {
            let city = cities[index]
            cityVisitManager.toggleVisit(for: city)
        }
    }
}
