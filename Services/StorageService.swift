import Foundation

class StorageService {
    static let shared = StorageService()
    private let teamsKey = "teams"
    private let tokenKey = "token"
    
    func saveTeams(_ teams: [Team]) {
        if let data = try? JSONEncoder().encode(teams) {
            UserDefaults.standard.set(data, forKey: teamsKey)
        }
    }
    
    func loadTeams() -> [Team] {
        if let data = UserDefaults.standard.data(forKey: teamsKey),
           let teams = try? JSONDecoder().decode([Team].self, from: data) {
            return teams
        }
        return []
    }
    
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    func loadToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }
} 