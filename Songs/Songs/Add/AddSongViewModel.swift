//
//  AddSongView.swift
//  SongsLive
//
//  Created by Sascha Sallès on 19/01/2022.
//

import SwiftUI

struct AddSongView: View {
    @ObservedObject var viewModel = AddSongViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Song title", text: $viewModel.songTitle)
                    DatePicker("Release Date", selection: $viewModel.date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                    RatingView(title: "Rate", rating: $viewModel.rate)
                } header: {
                    Text("Song")
                }

                Section {
                    NavigationLink {
                        ArtistsView()
                    } label: {
                        Label("Add artist", systemImage: "person.fill")
                    }
                } header: {
                    Text("Artist")
                }

                Section {
                    Toggle("Favorite song", isOn: $viewModel.isFavorite)
                        .toggleStyle(.automatic)
                        .tint(.accentColor)
                }

                Button {
                    viewModel.addSong()
                } label: {
                    HStack {
                        Spacer()
                        Text("Add song")
                            .font(.headline)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Add Song")
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

struct AddSongView_Previews: PreviewProvider {
    static var previews: some View {
        AddSongView()
    }
}
