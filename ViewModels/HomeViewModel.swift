import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var teams: [Team] = []
    @Published var token: String = ""
    @Published var error: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadInitialData()
    }
    
    func loadInitialData() {
        self.teams = StorageService.shared.loadTeams()
        self.token = StorageService.shared.loadToken() ?? ""
    }
    
    func saveToken(_ token: String) {
        self.token = token
        StorageService.shared.saveToken(token)
    }
    
    func addTeam(_ team: Team) {
        teams.append(team)
        StorageService.shared.saveTeams(teams)
    }
    
    func removeTeam(_ team: Team) {
        teams.removeAll { $0.id == team.id }
        StorageService.shared.saveTeams(teams)
    }
} 