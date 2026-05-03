import SwiftUI
import MapKit

class StatePolygon: MKPolygon {
    var stateName: String?
}

class TripPolyline: MKPolyline {
    var transportMode: TransportMode?
}

struct IndiaMapView: UIViewRepresentable {
    @ObservedObject var stateVisitManager: StateVisitManager
    @ObservedObject var cityVisitManager: CityVisitManager
    @ObservedObject var tripManager: TripManager
    
    let visitedStateColor: String
    let capitalMarkerColor: String
    let cityMarkerColor: String
    
    @AppStorage("mapStyle") private var mapStyle = "standard"
    @AppStorage("showTripsOnMap") private var showTripsOnMap = true
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        context.coordinator.mapView = mapView
        
        mapView.insetsLayoutMarginsFromSafeArea = false
        
        let indiaCenter = CLLocationCoordinate2D(latitude: 22.5937, longitude: 78.9629)
        let region = MKCoordinateRegion(center: indiaCenter, span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30))
        mapView.setRegion(region, animated: false)
        
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
        
        refreshMap(mapView)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        context.coordinator.parent = self
        uiView.mapType = mapStyle == "satellite" ? .satellite : .standard
        
        refreshMap(uiView)
    }
    
    private func refreshMap(_ mapView: MKMapView) {
        // Redraw overlays
        mapView.removeOverlays(mapView.overlays)
        loadGeoJSON(into: mapView)
        if showTripsOnMap {
            loadTrips(into: mapView)
        }
        
        // Update annotations
        updateAnnotations(on: mapView)
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
    
    private func loadTrips(into mapView: MKMapView) {
        var tripOverlays: [MKOverlay] = []
        for trip in tripManager.trips {
            var coordinates = [trip.origin.coordinate]
            coordinates.append(contentsOf: trip.stops.map { $0.coordinate })
            coordinates.append(trip.destination.coordinate)
            
            let polyline = TripPolyline(coordinates: coordinates, count: coordinates.count)
            polyline.transportMode = trip.transportMode
            tripOverlays.append(polyline)
        }
        mapView.addOverlays(tripOverlays)
    }
    
    private func updateAnnotations(on mapView: MKMapView) {
        mapView.removeAnnotations(mapView.annotations)
        
        var newAnnotations: [MKAnnotation] = []
        
        for city in cityVisitManager.visitedCities {
            let annotation = MKPointAnnotation()
            annotation.coordinate = city.coordinate
            annotation.title = city.name
            annotation.subtitle = city.isCapital ? "Capital" : nil
            newAnnotations.append(annotation)
        }
        
        mapView.addAnnotations(newAnnotations)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: IndiaMapView
        weak var mapView: MKMapView?
        
        init(_ parent: IndiaMapView) {
            self.parent = parent
            super.init()
            NotificationCenter.default.addObserver(self, selector: #selector(handleCenterMap), name: NSNotification.Name("CenterMap"), object: nil)
        }
        
        @objc func handleCenterMap() {
            guard let mapView = mapView else { return }
            let indiaCenter = CLLocationCoordinate2D(latitude: 22.5937, longitude: 78.9629)
            let region = MKCoordinateRegion(center: indiaCenter, span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30))
            mapView.setRegion(region, animated: true)
        }
        
        @objc func handleTap(_ gesture: UITapGestureRecognizer) {
            let mapView = gesture.view as! MKMapView
            let touchPoint = gesture.location(in: mapView)
            let coord = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            let mapPoint = MKMapPoint(coord)
            
            for overlay in mapView.overlays.reversed() {
                if let polygon = overlay as? StatePolygon {
                    let renderer = MKPolygonRenderer(polygon: polygon)
                    let rendererPoint = renderer.point(for: mapPoint)
                    
                    if renderer.path.contains(rendererPoint) {
                        if let stateName = polygon.stateName {
                            NotificationCenter.default.post(name: NSNotification.Name("StateTapped"), object: stateName)
                            return
                        }
                    }
                }
            }
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let statePolygon = overlay as? StatePolygon {
                let renderer = MKPolygonRenderer(polygon: statePolygon)
                
                let stateName = statePolygon.stateName ?? ""
                if parent.stateVisitManager.isVisited(stateName) {
                    renderer.fillColor = UIColor(Color(hex: parent.visitedStateColor)).withAlphaComponent(0.6)
                } else {
                    renderer.fillColor = UIColor.systemGray.withAlphaComponent(0.3)
                }
                
                renderer.strokeColor = UIColor.white
                renderer.lineWidth = 0.5
                
                return renderer
            } else if let tripPolyline = overlay as? TripPolyline {
                let renderer = MKPolylineRenderer(polyline: tripPolyline)
                renderer.strokeColor = UIColor.systemBlue.withAlphaComponent(0.8)
                renderer.lineWidth = 2.0
                renderer.lineDashPattern = [4, 4]
                return renderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation { return nil }
            
            let identifier = "CityAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
            
            // Check if it's a capital
            if let title = annotation.title, let state = parent.cityVisitManager.visitedCities.first(where: { $0.name == title })?.state {
                let isCapital = CapitalManager.shared.capital(for: state) == title

                let size: CGFloat = 8
                let colorHex = isCapital ? parent.capitalMarkerColor : parent.cityMarkerColor
                let color = UIColor(Color(hex: colorHex))

                annotationView?.image = circleImage(size: size, color: color)
            } else {
                let color = UIColor(Color(hex: parent.cityMarkerColor))
                annotationView?.image = circleImage(size: 6, color: color)
            }
            
            return annotationView
        }
        
        private func circleImage(size: CGFloat, color: UIColor) -> UIImage {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))
            return renderer.image { context in
                color.setFill()
                context.cgContext.fillEllipse(in: CGRect(x: 0, y: 0, width: size, height: size))
                
                UIColor.white.setStroke()
                context.cgContext.setLineWidth(1)
                context.cgContext.strokeEllipse(in: CGRect(x: 0.5, y: 0.5, width: size - 1, height: size - 1))
            }
        }
    }
}
