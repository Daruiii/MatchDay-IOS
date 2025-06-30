import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var showTokenView = false
    @State private var showAddTeamView = false
    @State private var selectedTeam: Team? = nil
    @State private var showTeams = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                LinearGradient(gradient: Gradient(colors: [Color("HeaderBg"), Color("Background")]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Text("MatchDay")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: { showTokenView = true }) {
                            Image(systemName: "key.fill")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.blue.opacity(0.8))
                                .clipShape(Circle())
                                .shadow(radius: 3)
                        }
                        .accessibilityLabel("Modifier le token PandaScore")
                    }
                    .padding([.top, .horizontal])
                    
                    if viewModel.teams.isEmpty {
                        Text("Aucune équipe enregistrée.")
                            .foregroundColor(.white.opacity(0.7))
                            .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 18) {
                                ForEach(Array(viewModel.teams.enumerated()), id: ".element.id") { index, team in
                                    Button(action: { selectedTeam = team }) {
                                        HStack(spacing: 16) {
                                            if let imageUrl = team.imageUrl, let url = URL(string: imageUrl) {
                                                AsyncImage(url: url) { image in
                                                    image.resizable().aspectRatio(contentMode: .fit)
                                                } placeholder: {
                                                    Color.gray.opacity(0.2)
                                                }
                                                .frame(width: 60, height: 60)
                                                .clipShape(Circle())
                                            } else {
                                                Image(systemName: "person.3.fill")
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                                    .foregroundColor(.gray)
                                            }
                                            VStack(alignment: .leading, spacing: 4) {
                                                Text(team.name)
                                                    .font(.title3).fontWeight(.semibold)
                                                    .foregroundColor(.white)
                                                if !team.slugs.isEmpty {
                                                    Text(team.slugs.joined(separator: ", "))
                                                        .font(.caption)
                                                        .foregroundColor(.white.opacity(0.7))
                                                }
                                            }
                                            Spacer()
                                            if team.notificate {
                                                Image(systemName: "bell.fill")
                                                    .foregroundColor(.yellow)
                                            }
                                        }
                                        .padding()
                                        .background(Color.white.opacity(0.08))
                                        .cornerRadius(18)
                                        .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 4)
                                        .opacity(showTeams ? 1 : 0)
                                        .offset(y: showTeams ? 0 : 20)
                                        .animation(.easeOut.delay(Double(index) * 0.07), value: showTeams)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    Spacer()
                }
                .navigationTitle("")
                .sheet(isPresented: $showTokenView) {
                    TokenView()
                }
                .sheet(isPresented: $showAddTeamView) {
                    AddTeamView()
                }
                .sheet(item: $selectedTeam) { team in
                    TeamDetailView(team: team)
                }
                
                Button(action: { showAddTeamView = true }) {
                    Image(systemName: "plus")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                        .padding()
                        .scaleEffect(showTeams ? 1 : 0.7)
                        .opacity(showTeams ? 1 : 0)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.2), value: showTeams)
                }
                .accessibilityLabel("Ajouter une équipe")
            }
            .onAppear {
                showTeams = true
            }
        }
    }
    
    private func deleteTeam(at offsets: IndexSet) {
        offsets.forEach { index in
            let team = viewModel.teams[index]
            viewModel.removeTeam(team)
        }
    }
} 