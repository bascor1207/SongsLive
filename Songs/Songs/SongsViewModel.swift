//
//  SongsViewModel.swift
//  SongsLive
//
//  Created by Sascha Sallès on 19/01/2022.
//

import SwiftUI
import CoreHaptics

class SongsViewModel: ObservableObject {
    @Published var showAddSongView: Bool = false
    @Published var showAlert: Bool = false
    @Published var songs = [Song]()

    // MARK: - Private
    private let dbManager = DBManager.shared

    init() {
        fetchSongs()
    }

    func fetchSongs() {
        let songsResult = dbManager.getAllSongs()
        switch songsResult {
        case .failure:              return
        case .success(let songs):   self.songs = songs
        }
    }

    func deleteSongs(at offsets: IndexSet) {
        offsets.forEach { index in
            let song = songs[index]
            dbManager.deleteSong(by: song.objectID)
        }
        songs.remove(atOffsets: offsets)
    }
}
