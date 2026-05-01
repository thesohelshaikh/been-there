import SwiftUI

struct ContentView: View {
    @StateObject var visitManager = StateVisitManager()
    
    var body: some View {
        IndiaMapView(visitManager: visitManager)
            .ignoresSafeArea(.all) // Explicitly ignore all safe areas
            .overlay(
                VStack {
                    Text("Been There")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(10)
                        .padding(.top, 10)
                    Spacer()
                }
            )
    }
}

#Preview {
    ContentView()
}
