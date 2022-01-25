
//
//  SongsViewModel.swift
//  SongsLive
//
//  Created by Sascha Sallès on 19/01/2022.
//

import SwiftUI
import CoreHaptics

class FavsViewModel: ObservableObject {
    @Published var favsSongs = [Song]()
//    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "Is favorite", "isFavorite == YES")) var favsSongs: FetchedResults<Song>

    // MARK: - Private
    private let dbManager = DBManager.shared

    init() {
        fetchSongs()
    }

    func fetchSongs() {
        let songsResult = dbManager.getFavsSongs()
        switch songsResult {
        case .failure:              return
        case .success(let favsSongs):   self.favsSongs = favsSongs
        }
    }
    

    func deleteSongs(at offsets: IndexSet) {
        offsets.forEach { index in
            let song = favsSongs[index]
            dbManager.deleteSong(by: song.objectID)
        }
        favsSongs.remove(atOffsets: offsets)
    }
}

