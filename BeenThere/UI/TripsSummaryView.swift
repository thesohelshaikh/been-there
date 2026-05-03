import SwiftUI

struct TripsSummaryView: View {
    @ObservedObject var viewModel: TripsSummaryViewModel

    var body: some View {
        ZStack {
            // Hidden NavigationLink to remove the chevron
            NavigationLink(destination: TripsDetailedSummaryView(viewModel: viewModel)) {
                EmptyView()
            }
            .opacity(0)

            VStack(alignment: .leading, spacing: 16) {
                Text("Travel Summary")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .padding(.top, 8)

                HStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 12) {
                        StatisticView(label: "States", value: "\(viewModel.totalStates)", icon: "map.fill", color: .blue)
                        StatisticView(label: "Cities", value: "\(viewModel.totalCities)", icon: "building.2.fill", color: .green)
                        StatisticView(label: "Trips", value: "\(viewModel.totalTrips)", icon: "road.lanes", color: .orange)
                    }

                    Spacer()
                    Divider()
                        .padding(.horizontal)
                    Spacer()

                    VStack(alignment: .leading, spacing: 12) {
                        StatisticView(label: "Total Distance", value: String(format: "%.0f km", viewModel.totalKilometers), icon: "arrow.triangle.pull", color: .purple)
                        StatisticView(label: "Avg. Length", value: String(format: "%.0f km", viewModel.averageTripLength), icon: "chart.line.uptrend.xyaxis", color: .pink)

                        // Added a placeholder for "Most Visited State" or similar to balance the UI
                        StatisticView(label: "Coverage", value: String(format: "%d%%", viewModel.totalStates > 0 ? Int((Double(viewModel.totalStates) / 36.0) * 100) : 0), icon: "percent", color: .teal)
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(16)
        }
    }
}

struct StatisticView: View {
    let label: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 28, height: 28)
                .background(color.gradient)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 1) {
                Text(label)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.bold)
            }
        }
    }
}
