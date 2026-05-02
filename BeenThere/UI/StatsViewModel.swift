import Foundation
import SwiftUI
import Combine

enum TravelRegion: String, CaseIterable, Identifiable {
    case north = "North India"
    case south = "South India"
    case east = "East India"
    case west = "West India"
    case central = "Central India"
    case northeast = "Northeast India"
    
    var id: String { self.rawValue }
}

enum EntityType {
    case state
    case ut
}

class StatsViewModel: ObservableObject {
    @ObservedObject var stateVisitManager: StateVisitManager
    
    struct Entity {
        let name: String
        let region: TravelRegion
        let type: EntityType
    }
    
    let allEntities: [Entity] = [
        // North
        Entity(name: "Delhi", region: .north, type: .ut),
        Entity(name: "Haryana", region: .north, type: .state),
        Entity(name: "Himachal Pradesh", region: .north, type: .state),
        Entity(name: "Jammu & Kashmir", region: .north, type: .ut),
        Entity(name: "Punjab", region: .north, type: .state),
        Entity(name: "Rajasthan", region: .north, type: .state),
        Entity(name: "Uttar Pradesh", region: .north, type: .state),
        Entity(name: "Uttarakhand", region: .north, type: .state),
        Entity(name: "Ladakh", region: .north, type: .ut),
        Entity(name: "Chandigarh", region: .north, type: .ut),
        // South
        Entity(name: "Andhra Pradesh", region: .south, type: .state),
        Entity(name: "Karnataka", region: .south, type: .state),
        Entity(name: "Kerala", region: .south, type: .state),
        Entity(name: "Tamil Nadu", region: .south, type: .state),
        Entity(name: "Telangana", region: .south, type: .state),
        Entity(name: "Andaman & Nicobar", region: .south, type: .ut),
        Entity(name: "Lakshadweep", region: .south, type: .ut),
        Entity(name: "Puducherry", region: .south, type: .ut),
        // West
        Entity(name: "Goa", region: .west, type: .state),
        Entity(name: "Gujarat", region: .west, type: .state),
        Entity(name: "Maharashtra", region: .west, type: .state),
        Entity(name: "Dadra and Nagar Haveli and Daman and Diu", region: .west, type: .ut),
        // East
        Entity(name: "Bihar", region: .east, type: .state),
        Entity(name: "Jharkhand", region: .east, type: .state),
        Entity(name: "Odisha", region: .east, type: .state),
        Entity(name: "West Bengal", region: .east, type: .state),
        // Central
        Entity(name: "Chhattisgarh", region: .central, type: .state),
        Entity(name: "Madhya Pradesh", region: .central, type: .state),
        // Northeast
        Entity(name: "Arunachal Pradesh", region: .northeast, type: .state),
        Entity(name: "Assam", region: .northeast, type: .state),
        Entity(name: "Manipur", region: .northeast, type: .state),
        Entity(name: "Meghalaya", region: .northeast, type: .state),
        Entity(name: "Mizoram", region: .northeast, type: .state),
        Entity(name: "Nagaland", region: .northeast, type: .state),
        Entity(name: "Sikkim", region: .northeast, type: .state),
        Entity(name: "Tripura", region: .northeast, type: .state)
    ]
    
    var totalEntitiesCount: Int { allEntities.count }
    var visitedEntitiesCount: Int { stateVisitManager.visitedStates.count }
    var coveragePercentage: Double {
        totalEntitiesCount > 0 ? Double(visitedEntitiesCount) / Double(totalEntitiesCount) : 0
    }
    
    // Separate Stats
    var totalStatesCount: Int { allEntities.filter { $0.type == .state }.count }
    var visitedStatesCount: Int { allEntities.filter { $0.type == .state && stateVisitManager.isVisited($0.name) }.count }
    
    var totalUTsCount: Int { allEntities.filter { $0.type == .ut }.count }
    var visitedUTsCount: Int { allEntities.filter { $0.type == .ut && stateVisitManager.isVisited($0.name) }.count }
    
    var entitiesLeftToGo: Int { totalEntitiesCount - visitedEntitiesCount }
    
    init(stateVisitManager: StateVisitManager) {
        self.stateVisitManager = stateVisitManager
    }
    
    func entities(in region: TravelRegion) -> [Entity] {
        allEntities.filter { $0.region == region }
    }
    
    func stats(for region: TravelRegion) -> (visited: Int, total: Int, percentage: Int) {
        let regionEntities = entities(in: region)
        let visited = regionEntities.filter { stateVisitManager.isVisited($0.name) }.count
        let total = regionEntities.count
        let percentage = total > 0 ? Int((Double(visited) / Double(total)) * 100) : 0
        return (visited, total, percentage)
    }
}
