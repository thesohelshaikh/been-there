import SwiftUI
import MapKit

struct CitySearchView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CitySearchViewModel()
    var onCitySelected: (City) -> Void
    
    var body: some View {
        NavigationView {
            List(viewModel.completions, id: \.self) { completion in
                Button(action: {
                    viewModel.selectCompletion(completion) { city in
                        if let city = city {
                            onCitySelected(city)
                            dismiss()
                        }
                    }
                }) {
                    VStack(alignment: .leading) {
                        Text(completion.title)
                            .font(.headline)
                        Text(completion.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Search City")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if viewModel.isSearching {
                        ProgressView()
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "City name in India")
        }
    }
}
