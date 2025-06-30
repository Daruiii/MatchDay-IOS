import Foundation

struct Team: Identifiable, Codable {
    let id: UUID
    var name: String
    var imageUrl: String?
    var slugs: [String]
    var eventColor: String?
    var secondColor: String?
    var notificate: Bool
    // Ajoute d'autres propriétés selon besoin
    
    init(id: UUID = UUID(), name: String, imageUrl: String? = nil, slugs: [String] = [], eventColor: String? = nil, secondColor: String? = nil, notificate: Bool = true) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.slugs = slugs
        self.eventColor = eventColor
        self.secondColor = secondColor
        self.notificate = notificate
    }
} 