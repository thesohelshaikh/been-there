import SwiftUI
import MapKit

class StatePolygon: MKPolygon {
    var stateName: String?
}

struct IndiaMapView: UIViewRepresentable {
    @ObservedObject var visitManager: StateVisitManager
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        // Center on India
        let indiaCenter = CLLocationCoordinate2D(latitude: 20.5937, longitude: 78.9629)
        let region = MKCoordinateRegion(center: indiaCenter, span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        mapView.setRegion(region, animated: false)
        
        // Add Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
        
        loadGeoJSON(into: mapView)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // Redraw overlays when visitManager changes
        uiView.removeOverlays(uiView.overlays)
        loadGeoJSON(into: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    private func loadGeoJSON(into mapView: MKMapView) {
        guard let url = Bundle.main.url(forResource: "india_states", withExtension: "geojson"),
              let data = try? Data(contentsOf: url) else {
            return
        }
        
        do {
            let decoder = MKGeoJSONDecoder()
            let objects = try decoder.decode(data)
            
            var overlays: [MKOverlay] = []
            
            for object in objects {
                if let feature = object as? MKGeoJSONFeature {
                    for geometry in feature.geometry {
                        if let polygon = geometry as? MKPolygon {
                            let statePolygon = StatePolygon(points: polygon.points(), count: polygon.pointCount, interiorPolygons: polygon.interiorPolygons)
                            
                            if let propertiesData = feature.properties,
                               let properties = try? JSONSerialization.jsonObject(with: propertiesData) as? [String: Any],
                               let stateName = properties["ST_NM"] as? String {
                                statePolygon.stateName = stateName
                            }
                            overlays.append(statePolygon)
                        } else if let multiPolygon = geometry as? MKMultiPolygon {
                            for polygon in multiPolygon.polygons {
                                let statePolygon = StatePolygon(points: polygon.points(), count: polygon.pointCount, interiorPolygons: polygon.interiorPolygons)
                                
                                if let propertiesData = feature.properties,
                                   let properties = try? JSONSerialization.jsonObject(with: propertiesData) as? [String: Any],
                                   let stateName = properties["ST_NM"] as? String {
                                    statePolygon.stateName = stateName
                                }
                                overlays.append(statePolygon)
                            }
                        }
                    }
                }
            }
            mapView.addOverlays(overlays)
        } catch {
            print("Error decoding GeoJSON: \(error)")
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: IndiaMapView
        
        init(_ parent: IndiaMapView) {
            self.parent = parent
        }
        
        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            let mapView = gesture.view as! MKMapView
            let touchPoint = gesture.location(in: mapView)
            let coord = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let mapPoint = MKMapPoint(coord)
            
            // Find the top-most polygon that contains the tapped point
            for overlay in mapView.overlays.reversed() {
                if let polygon = overlay as? StatePolygon {
                    let renderer = MKPolygonRenderer(polygon: polygon)
                    let rendererPoint = renderer.point(for: mapPoint)
                    
                    if renderer.path.contains(rendererPoint) {
                        if let stateName = polygon.stateName {
                            parent.visitManager.toggleVisit(for: stateName)
                            return // Toggle one state at a time
                        }
                    }
                }
            }
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let statePolygon = overlay as? StatePolygon {
                let renderer = MKPolygonRenderer(polygon: statePolygon)
                
                let stateName = statePolygon.stateName ?? ""
                if parent.visitManager.isVisited(stateName) {
                    renderer.fillColor = UIColor.systemGreen.withAlphaComponent(0.6)
                } else {
                    renderer.fillColor = UIColor.systemGray.withAlphaComponent(0.2)
                }
                
                renderer.strokeColor = UIColor.white
                renderer.lineWidth = 0.5
                
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
