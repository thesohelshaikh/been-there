import SwiftUI

struct StateItem: Identifiable {
    let name: String
    var id: String { name }
}

struct ContentView: View {
    @StateObject var cityVisitManager = CityVisitManager()
    @StateObject var stateVisitManager: StateVisitManager

    @AppStorage("visitedStateColor") private var visitedStateColor = "2D6A4F"
    @AppStorage("capitalMarkerColor") private var capitalMarkerColor = "FFD700"
    @AppStorage("cityMarkerColor") private var cityMarkerColor = "34C759"

    @State private var selectedTab = 0
    @State private var selectedState: StateItem? = nil

    init() {
        let cityManager = CityVisitManager()
        _cityVisitManager = StateObject(wrappedValue: cityManager)
        _stateVisitManager = StateObject(wrappedValue: StateVisitManager(cityVisitManager: cityManager))
    }

    var body: some View {
        TabView(selection: Binding(
            get: { self.selectedTab },
            set: { newValue in
                if newValue == self.selectedTab && newValue == 0 {
                    NotificationCenter.default.post(name: NSNotification.Name("CenterMap"), object: nil)
                }
                self.selectedTab = newValue
            }
        )) {
            IndiaMapView(
                stateVisitManager: stateVisitManager,
                cityVisitManager: cityVisitManager,
                visitedStateColor: visitedStateColor,
                capitalMarkerColor: capitalMarkerColor,
                cityMarkerColor: cityMarkerColor
            )
                .ignoresSafeArea()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(0)

            StatsView(viewModel: StatsViewModel(stateVisitManager: stateVisitManager))
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
                .tag(1)
            
            Text("Coming Soon!")
                .tabItem {
                    Label("Places", systemImage: "mappin.and.ellipse")
                }
                .tag(2)
            
            SettingsView(visitManager: stateVisitManager)
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(3)
        }
        .accentColor(Color(hex: "2D6A4F"))
        .sheet(item: $selectedState) { item in
            CitySelectionSheet(stateName: item.name, cityVisitManager: cityVisitManager)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("StateTapped"))) { notification in
            if let stateName = notification.object as? String {
                self.selectedState = StateItem(name: stateName)
            }
        }
    }
}

#Preview {
    ContentView()
}
