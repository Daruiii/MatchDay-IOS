import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var showTokenView = false
    @State private var notif0 = true
    @State private var notif5 = false
    @State private var notif10 = false
    @State private var notif30 = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("HeaderBg"), Color("Background")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 28) {
                    HStack {
                        Text("Paramètres")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
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
                    VStack(spacing: 18) {
                        Button(action: { showTokenView = true }) {
                            HStack {
                                Text("PandaScore Token")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .padding()
                            .background(Color.white.opacity(0.08))
                            .cornerRadius(12)
                        }
                        .buttonStyle(PlainButtonStyle())
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Notifications 🔔")
                                .font(.headline)
                                .foregroundColor(.white)
                            VStack(spacing: 12) {
                                Toggle("Notification 0 min", isOn: $notif0)
                                    .tint(.yellow)
                                Toggle("Notification 5 min", isOn: $notif5)
                                    .tint(.yellow)
                                Toggle("Notification 10 min", isOn: $notif10)
                                    .tint(.yellow)
                                Toggle("Notification 30 min", isOn: $notif30)
                                    .tint(.yellow)
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                        .background(Color.white.opacity(0.08))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    Spacer()
                }
                .sheet(isPresented: $showTokenView) {
                    TokenView()
                }
            }
        }
    }
} 