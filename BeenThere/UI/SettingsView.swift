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
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("visitedStateColor") private var visitedStateColor = "2D6A4F"
    @AppStorage("capitalMarkerColor") private var capitalMarkerColor = "FFD700"
    @AppStorage("cityMarkerColor") private var cityMarkerColor = "34C759"
    @AppStorage("mapStyle") private var mapStyle = "standard"
    
    @State private var showingExportSheet = false
    @State private var showingImportSheet = false
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
                    Picker("Map Style", selection: $mapStyle) {
                        Text("Standard").tag("standard")
                        Text("Satellite").tag("satellite")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button(role: .destructive, action: resetToDefaults) {
                        HStack {
                            Spacer()
                            Text("Reset to Defaults")
                            Spacer()
                        }
                    }
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
    SettingsView(visitManager: StateVisitManager(cityVisitManager: CityVisitManager()))
}
