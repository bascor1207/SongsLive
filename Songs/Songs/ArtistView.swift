//
//  SongsView.swift
//  SongsLive
//
//  Created by Sascha Sallès on 19/01/2022.
//

import SwiftUI

struct ArtistsView: View {
    @ObservedObject private var viewModel = ArtistsViewModel()

    var body: some View {
        NavigationView {
            List {
                if viewModel.artists.isEmpty {
                    HStack {
                        Spacer()
                        Text("Please add an artist")
                        Spacer()
                    }
                } else {
                    ForEach(viewModel.artists) { artist in
                        HStack {
                            if let artistName: String = "\(artist.firstName! + " " + artist.lastName!)" {
                                Text(artistName)
                            }
                        }
                    }.onDelete { offsets in
                        viewModel.deleteArtist(at: offsets)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .animation(.easeInOut, value: viewModel.artists)
            .navigationTitle("Artists")
            .navigationBarItems(
                trailing:
                    Button {
                        viewModel.showAddArtistsView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
            ).sheet(
                isPresented: $viewModel.showAddArtistsView,
                onDismiss: {
                    viewModel.fetchArtists()
                }) { AddArtistView() }
        }
        .onAppear {
            viewModel.fetchArtists()
        }
    }
}

struct ArtistsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsView()
    }
}
