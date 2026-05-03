import SwiftUI
import UniformTypeIdentifiers

struct TravelDataDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.json] }
    var data: Data

    init(data: Data = Data()) {
        self.data = data
    }

    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            self.data = data
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: data)
    }
}

struct SettingsView: View {
    @ObservedObject var visitManager: StateVisitManager
    @ObservedObject var tripManager: TripManager
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("visitedStateColor") private var visitedStateColor = "2D6A4F"
    @AppStorage("capitalMarkerColor") private var capitalMarkerColor = "FFD700"
    @AppStorage("cityMarkerColor") private var cityMarkerColor = "34C759"
    @AppStorage("mapStyle") private var mapStyle = "standard"
    @AppStorage("showTripsOnMap") private var showTripsOnMap = true
    
    @State private var showingExportSheet = false
    @State private var showingImportSheet = false
    @State private var showingResetConfirmation = false
    @State private var showingClearTripsConfirmation = false
    @State private var exportDocument: TravelDataDocument?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                    
                    ColorPicker("Visited State Color", selection: Binding(
                        get: { Color(hex: visitedStateColor) },
                        set: { newColor in
                            visitedStateColor = colorToHex(newColor)
                        }
                    ))
                    
                    ColorPicker("Capital Marker Color", selection: Binding(
                        get: { Color(hex: capitalMarkerColor) },
                        set: { newColor in
                            capitalMarkerColor = colorToHex(newColor)
                        }
                    ))
                    
                    ColorPicker("City Marker Color", selection: Binding(
                        get: { Color(hex: cityMarkerColor) },
                        set: { newColor in
                            cityMarkerColor = colorToHex(newColor)
                        }
                    ))
                }
                
                Section(header: Text("Map Settings")) {
                    Toggle("Show Trips on Map", isOn: $showTripsOnMap)
                    
                    Picker("Map Style", selection: $mapStyle) {
                        Text("Standard").tag("standard")
                        Text("Satellite").tag("satellite")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Data Management")) {
                    Button(action: {
                        if let data = visitManager.exportData() {
                            exportDocument = TravelDataDocument(data: data)
                            showingExportSheet = true
                        }
                    }) {
                        Label("Export Visited Data", systemImage: "square.and.arrow.up")
                    }
                    
                    Button(action: {
                        showingImportSheet = true
                    }) {
                        Label("Import Visited Data", systemImage: "square.and.arrow.down")
                    }
                    
                    Button(role: .destructive, action: { showingClearTripsConfirmation = true }) {
                        Label("Clear All Trips", systemImage: "trash")
                    }
                    
                    Button(role: .destructive, action: { showingResetConfirmation = true }) {
                        Label("Reset App Settings", systemImage: "arrow.counterclockwise")
                    }
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0")
                            .foregroundColor(.secondary)
                    }
                    
                    Link(destination: URL(string: "https://github.com/thesohelshaikh/been-there")!) {
                        Label("Source Code (GitHub)", systemImage: "link")
                    }
                }
            }
            .navigationTitle("Settings")
            .alert("Reset Settings", isPresented: $showingResetConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive, action: resetToDefaults)
            } message: {
                Text("Are you sure you want to reset all appearance settings to their default values? Your visited data and trips will not be affected.")
            }
            .alert("Clear All Trips", isPresented: $showingClearTripsConfirmation) {
                Button("Cancel", role: .cancel) { }
                Button("Clear", role: .destructive) {
                    tripManager.clearAllTrips()
                }
            } message: {
                Text("Are you sure you want to delete all recorded trips? This action cannot be undone.")
            }
            .fileExporter(
                isPresented: $showingExportSheet,
                document: exportDocument,
                contentType: .json,
                defaultFilename: "visited_states.json"
            ) { result in
                // Handle result
            }
            .fileImporter(
                isPresented: $showingImportSheet,
                allowedContentTypes: [.json],
                allowsMultipleSelection: false
            ) { result in
                switch result {
                case .success(let urls):
                    if let url = urls.first {
                        if url.startAccessingSecurityScopedResource() {
                            if let data = try? Data(contentsOf: url) {
                                _ = visitManager.importData(from: data)
                            }
                            url.stopAccessingSecurityScopedResource()
                        }
                    }
                case .failure:
                    break
                }
            }
        }
    }
    
    private func resetToDefaults() {
        visitedStateColor = "2D6A4F"
        capitalMarkerColor = "FFD700"
        cityMarkerColor = "34C759"
        mapStyle = "standard"
        isDarkMode = false
    }
    
    private func colorToHex(_ color: Color) -> String {
        if let uiColor = UIColor(color).cgColor.components {
            let r = Int(uiColor[0] * 255)
            let g = Int(uiColor[1] * 255)
            let b = Int(uiColor[2] * 255)
            return String(format: "%02X%02X%02X", r, g, b)
        }
        return "000000"
    }
}

#Preview {
    SettingsView(visitManager: StateVisitManager(cityVisitManager: CityVisitManager()), tripManager: TripManager())
}
