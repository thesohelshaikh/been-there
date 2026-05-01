import SwiftUI

struct ContentView: View {
    @StateObject var visitManager = StateVisitManager()
    
    var body: some View {
        IndiaMapView(visitManager: visitManager)
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Text("Been There")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Capsule().fill(Color.white.opacity(0.8)))
                        .padding(.top, 10)
                    Spacer()
                }
            )
    }
}

#Preview {
    ContentView()
}
