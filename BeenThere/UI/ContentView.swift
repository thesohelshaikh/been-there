import SwiftUI

struct ContentView: View {
    @StateObject var stateVisitManager = StateVisitManager()
    @State private var selectedTab = 1
    
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
            
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(3)
        }
        .accentColor(Color(hex: "2D6A4F"))
    }
}

#Preview {
    ContentView()
}
