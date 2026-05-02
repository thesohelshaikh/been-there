import SwiftUI

struct StatsView: View {
    @ObservedObject var viewModel: StatsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Your Journey")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .padding(.horizontal)
                
                // Top Progress Card
                ProgressCard(viewModel: viewModel)
                    .padding(.horizontal)
                
                // Stats Row
                HStack(spacing: 16) {
                    MiniStatCard(
                        value: "\(viewModel.visitedStatesCount)",
                        title: "States",
                        subtitle: "of \(viewModel.totalStatesCount) visited"
                    )
                    MiniStatCard(
                        value: "\(viewModel.visitedUTsCount)",
                        title: "UTs",
                        subtitle: "of \(viewModel.totalUTsCount) visited"
                    )
                }
                .padding(.horizontal)
                
                // By Region Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("BY REGION")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    VStack(spacing: 0) {
                        ForEach(TravelRegion.allCases) { region in
                            RegionProgressRow(region: region, viewModel: viewModel)
                            if region != TravelRegion.allCases.last {
                                Divider().padding(.leading)
                            }
                        }
                    }
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 100)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
    }
}

struct ProgressCard: View {
    @ObservedObject var viewModel: StatsViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 12)
                Circle()
                    .trim(from: 0, to: viewModel.coveragePercentage)
                    .stroke(Color(hex: "2D6A4F"), style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                
                VStack {
                    Text("\(Int(viewModel.coveragePercentage * 100))%")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "2D6A4F"))
                    Text("India")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("India Progress")
                    .font(.headline)
                Text("\(viewModel.visitedEntitiesCount) of \(viewModel.totalEntitiesCount) entities explored")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(viewModel.entitiesLeftToGo) left to go!")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color(hex: "2D6A4F"))
            }
            Spacer()
        }
        .padding(24)
        .background(Color(.systemBackground))
        .cornerRadius(20)
    }
}

struct MiniStatCard: View {
    let value: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(value)
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundColor(Color(hex: "2D6A4F"))
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(20)
    }
}

struct RegionProgressRow: View {
    let region: TravelRegion
    @ObservedObject var viewModel: StatsViewModel
    
    var body: some View {
        let stats = viewModel.stats(for: region)
        VStack(spacing: 8) {
            HStack {
                Text(region.rawValue)
                    .font(.body)
                    .fontWeight(.medium)
                Spacer()
                Text("\(stats.visited)/\(stats.total) • \(stats.percentage)%")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 6)
                    Capsule()
                        .fill(Color(hex: "2D6A4F"))
                        .frame(width: geo.size.width * CGFloat(Double(stats.percentage) / 100.0), height: 6)
                }
            }
            .frame(height: 6)
        }
        .padding()
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(viewModel: StatsViewModel(stateVisitManager: StateVisitManager(cityVisitManager: CityVisitManager())))
    }
}
