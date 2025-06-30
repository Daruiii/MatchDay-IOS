import SwiftUI

struct TeamDetailView: View {
    let team: Team
    @StateObject private var viewModel = TeamDetailViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var token: String = StorageService.shared.loadToken() ?? ""
    @State private var showNotifAlert = false
    @State private var notifMessage = ""
    @State private var showMatches = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("HeaderBg"), Color("Background")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 24) {
                    if let imageUrl = team.imageUrl, let url = URL(string: imageUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable().aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(radius: 8)
                    }
                    Text(team.name)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    if !team.slugs.isEmpty {
                        Text("Slugs : " + team.slugs.joined(separator: ", "))
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    Toggle("Notifications activées", isOn: .constant(team.notificate))
                        .disabled(true)
                        .tint(.yellow)
                    Divider().background(Color.white.opacity(0.5))
                    Text("Prochains matchs")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let error = viewModel.error {
                        Text("Erreur : \(error)")
                            .foregroundColor(.red)
                    } else if viewModel.matches.isEmpty {
                        Text("Aucun match à venir trouvé.")
                            .foregroundColor(.white.opacity(0.7))
                    } else {
                        VStack(spacing: 18) {
                            ForEach(Array(viewModel.matches.enumerated()), id: ".element.id") { index, match in
                                HStack(alignment: .center, spacing: 16) {
                                    if let imageUrl = match.imageUrl, let url = URL(string: imageUrl) {
                                        AsyncImage(url: url) { image in
                                            image.resizable().aspectRatio(contentMode: .fit)
                                        } placeholder: {
                                            Color.gray.opacity(0.2)
                                        }
                                        .frame(width: 50, height: 50)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } else {
                                        Image(systemName: "sportscourt")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.gray)
                                    }
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(match.opponent)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        if let event = match.event {
                                            Text(event)
                                                .font(.subheadline)
                                                .foregroundColor(.white.opacity(0.7))
                                        }
                                        Text(match.date, style: .date)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.7))
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(Color.white.opacity(0.10))
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.18), radius: 6, x: 0, y: 4)
                                .opacity(showMatches ? 1 : 0)
                                .offset(y: showMatches ? 0 : 20)
                                .animation(.easeOut.delay(Double(index) * 0.07), value: showMatches)
                            }
                        }
                        Button(action: scheduleNotifications) {
                            Label("Activer les notifications pour ces matchs", systemImage: "bell.badge.fill")
                                .font(.headline)
                                .padding()
                                .background(Color.yellow.opacity(0.9))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                        }
                        .padding(.top, 8)
                    }
                    Spacer()
                }
                .padding()
            }
        }
        .navigationTitle("Détail équipe")
        .onAppear {
            viewModel.fetchUpcomingMatches(for: team, token: token)
            showMatches = true
        }
        .alert(isPresented: $showNotifAlert) {
            Alert(title: Text("Notifications"), message: Text(notifMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func scheduleNotifications() {
        NotificationService.shared.requestAuthorization { granted in
            if granted {
                for match in viewModel.matches {
                    NotificationService.shared.scheduleMatchNotification(match: match, team: team)
                }
                notifMessage = "Notifications programmées pour les prochains matchs !"
            } else {
                notifMessage = "Autorisation refusée. Activez les notifications dans les réglages."
            }
            showNotifAlert = true
        }
    }
} 