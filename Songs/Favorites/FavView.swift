
//
//  SongsView.swift
//  SongsLive
//
//  Created by Sascha Sallès on 19/01/2022.
//

import SwiftUI

struct FavsView: View {
    @ObservedObject private var viewModel = FavsViewModel()

    var body: some View {
        NavigationView {
            List {
                if viewModel.favsSongs.isEmpty {
                    HStack {
                        Spacer()
                        Text("Please add a new song")
                        Spacer()
                    }
                } else {
                    ForEach(viewModel.favsSongs) { song in
                        HStack {
                            if let title = song.title {
                                Text(title)
                            }
            
                        }
                    }.onDelete { offsets in
                        viewModel.deleteSongs(at: offsets)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .animation(.easeInOut, value: viewModel.favsSongs)
            .navigationTitle("Songs")
        }
        .onAppear {
            viewModel.fetchSongs()
        }
    }
}

struct FavsView_Previews: PreviewProvider {
    static var previews: some View {
        SongsView()
    }
}
