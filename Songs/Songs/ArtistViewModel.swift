//
//  SongsViewModel.swift
//  SongsLive
//
//  Created by Sascha Sallès on 19/01/2022.
//

import SwiftUI
import CoreHaptics

class ArtistsViewModel: ObservableObject {
    @Published var showAddArtistsView: Bool = false
    @Published var showAlert: Bool = false
    @Published var artists = [Artist]()

    // MARK: - Private
    private let dbManager = DBManager.shared

    init() {
        fetchArtists()
    }

    func fetchArtists() {
        let artistsResult = dbManager.getAllArtists()
        switch artistsResult {
        case .failure:              return
        case .success(let artists):   self.artists = artists
        }
    }

    func deleteArtist(at offsets: IndexSet) {
        offsets.forEach { index in
            let artist = artists[index]
            dbManager.deleteArtist (by: artist.objectID)
        }
        artists.remove(atOffsets: offsets)
    }
}
