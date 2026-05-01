import SwiftUI

struct ContentView: View {
    @StateObject var visitManager = StateVisitManager()
    
    var body: some View {
        ZStack(alignment: .top) {
            IndiaMapView(visitManager: visitManager)
                .edgesIgnoringSafeArea(.all)
            
            Text("Been There")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .padding()
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)
                .padding(.top, 50)
        }
    }
}

#Preview {
    ContentView()
}
