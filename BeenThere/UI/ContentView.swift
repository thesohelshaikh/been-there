import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "map")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Welcome to Been There!")
                .font(.title)
            Text("Track your travels across India.")
                .font(.subheadline)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
