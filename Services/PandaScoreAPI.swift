import Foundation

struct PandaScoreMatchDTO: Decodable {
    let id: Int
    let opponents: [OpponentDTO]
    let begin_at: String?
    let name: String?
    let league: LeagueDTO?
    let serie: SerieDTO?
    // Ajoute d'autres champs si besoin
}

struct OpponentDTO: Decodable {
    let opponent: OpponentDetailDTO
}

struct OpponentDetailDTO: Decodable {
    let name: String
    let image_url: String?
}

struct LeagueDTO: Decodable {
    let name: String?
}

struct SerieDTO: Decodable {
    let full_name: String?
}

class PandaScoreAPI {
    static let shared = PandaScoreAPI()
    private let baseURL = "https://api.pandascore.io/"
    
    func fetchUpcomingMatches(for teamSlug: String, token: String, completion: @escaping (Result<[Match], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)matches/upcoming?filter[opponent.slug]=\(teamSlug)&token=\(token)") else {
            completion(.failure(NSError(domain: "URL", code: 0, userInfo: nil)))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "Data", code: 0, userInfo: nil)))
                return
            }
            do {
                let dtos = try JSONDecoder().decode([PandaScoreMatchDTO].self, from: data)
                let matches = dtos.map { dto in
                    Match(
                        id: UUID(),
                        teamId: UUID(), // à adapter si tu veux relier à une Team
                        opponent: dto.opponents.first?.opponent.name ?? "?",
                        date: ISO8601DateFormatter().date(from: dto.begin_at ?? "") ?? Date(),
                        event: dto.league?.name ?? dto.serie?.full_name ?? dto.name,
                        imageUrl: dto.opponents.first?.opponent.image_url,
                        notificate: true
                    )
                }
                completion(.success(matches))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
} 