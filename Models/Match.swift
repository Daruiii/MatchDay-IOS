import Foundation

struct Match: Identifiable, Codable {
    let id: UUID
    var teamId: UUID
    var opponent: String
    var date: Date
    var event: String?
    var imageUrl: String?
    // Ajoute d'autres propriétés selon besoin
    
    init(id: UUID = UUID(), teamId: UUID, opponent: String, date: Date, event: String? = nil, imageUrl: String? = nil) {
        self.id = id
        self.teamId = teamId
        self.opponent = opponent
        self.date = date
        self.event = event
        self.imageUrl = imageUrl
    }
} 