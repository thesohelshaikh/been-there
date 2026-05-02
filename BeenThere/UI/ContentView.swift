import SwiftUI

struct ContentView: View {
    @StateObject var cityVisitManager = CityVisitManager()
    @StateObject var stateVisitManager: StateVisitManager
    
    @State private var selectedTab = 0
    @State private var selectedStateName: String? = nil
    @State private var showingCitySheet = false
    
    init() {
        let cityManager = CityVisitManager()
        _cityVisitManager = StateObject(wrappedValue: cityManager)
        _stateVisitManager = StateObject(wrappedValue: StateVisitManager(cityVisitManager: cityManager))
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            IndiaMapView(visitManager: stateVisitManager)
                .ignoresSafeArea(edges: .top)
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
        // Present sheet when a state is tapped (Task 3.2)
        .sheet(isPresented: $showingCitySheet) {
            if let stateName = selectedStateName {
                // CitySelectionSheet will be implemented in Task 2.1
                Text("Select cities in \(stateName)")
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("StateTapped"))) { notification in
            if let stateName = notification.object as? String {
                self.selectedStateName = stateName
                self.showingCitySheet = true
            }
        }
    }
}

#Preview {
    ContentView()
}
