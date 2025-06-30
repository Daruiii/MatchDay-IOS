import SwiftUI

struct AddTeamView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var imageUrl: String = ""
    @State private var slugs: String = ""
    @State private var notificate: Bool = true
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nom de l'équipe")) {
                    TextField("Nom", text: $name)
                }
                Section(header: Text("URL du logo (optionnel)")) {
                    TextField("https://...", text: $imageUrl)
                        .keyboardType(.URL)
                }
                Section(header: Text("Slugs (séparés par des virgules)")) {
                    TextField("ex: team1,team2", text: $slugs)
                }
                Section(header: Text("Recevoir des notifications ?")) {
                    Toggle("Notifications activées", isOn: $notificate)
                }
                Button("Ajouter l'équipe") {
                    let team = Team(
                        name: name,
                        imageUrl: imageUrl.isEmpty ? nil : imageUrl,
                        slugs: slugs.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) },
                        notificate: notificate
                    )
                    viewModel.addTeam(team)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(name.isEmpty)
            }
            .navigationTitle("Ajouter une équipe")
            .navigationBarItems(trailing: Button("Annuler") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
} 