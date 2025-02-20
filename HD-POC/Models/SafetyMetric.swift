import Foundation

struct SafetyMetric: Identifiable {
    let id = UUID()
    let name: String
    let score: Double
    let icon: String
}
