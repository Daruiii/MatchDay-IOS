import SwiftUI

struct MenuView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var showAddTeamView = false
    @State private var showSettings = false
    @State private var selectedTeam: Team? = nil
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            LinearGradient(gradient: Gradient(colors: [Color("HeaderBg"), Color("Background")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button(action: { showSettings = true }) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue.opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .accessibilityLabel("Paramètres")
                    Spacer()
                    Text("Menu")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: { showAddTeamView = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.blue.opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .accessibilityLabel("Ajouter une équipe")
                }
                .padding([.top, .horizontal])
                ScrollView {
                    VStack(spacing: 18) {
                        ForEach(viewModel.teams) { team in
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
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal)
                }
                Spacer()
            }
            .sheet(isPresented: $showAddTeamView) {
                AddTeamView()
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .sheet(item: $selectedTeam) { team in
                TeamDetailView(team: team)
            }
        }
    }
} 