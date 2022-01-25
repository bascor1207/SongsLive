//
//  AddSongView.swift
//  SongsLive
//
//  Created by Sascha Sallès on 19/01/2022.
//

import SwiftUI

struct AddArtistView: View {
    @ObservedObject var viewModel = AddArtistViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Artist FirstName", text: $viewModel.firstName)
                    TextField("Artist LastName", text: $viewModel.lastName)
                } header: {
                    Text("Artist")
                }
                Button {
                    viewModel.addArtist()
                } label: {
                    HStack {
                        Spacer()
                        Text("Add Artist")
                            .font(.headline)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Add Artist")
            .navigationBarTitleDisplayMode(.inline)
            .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {
                    presentationMode.wrappedValue.dismiss()
                }} message: {
                    Text(viewModel.alertMessage)
                }
        }
    }
}

struct AddArtistView_Previews: PreviewProvider {
    static var previews: some View {
        AddArtistView()
    }
}
