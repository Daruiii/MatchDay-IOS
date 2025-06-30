import Foundation

class TeamDetailViewModel: ObservableObject {
    @Published var matches: [Match] = []
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    func fetchUpcomingMatches(for team: Team, token: String) {
        guard let slug = team.slugs.first, !token.isEmpty else {
            self.error = "Aucun slug ou token fourni."
            return
        }
        isLoading = true
        PandaScoreAPI.shared.fetchUpcomingMatches(for: slug, token: token) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let matches):
                    self.matches = matches
                case .failure(let error):
                    self.error = error.localizedDescription
                }
            }
        }
    }
} 