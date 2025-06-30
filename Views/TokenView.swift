import SwiftUI

struct TokenView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var inputToken: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Entrer votre token PandaScore")
                .font(.headline)
            TextField("Token...", text: $inputToken)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            Button("Sauvegarder") {
                viewModel.saveToken(inputToken)
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
        .onAppear {
            inputToken = viewModel.token
        }
    }
} 