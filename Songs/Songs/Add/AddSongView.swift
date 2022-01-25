//
//  AddSongViewModel.swift
//  SongsLive
//
//  Created by Sascha Sallès on 19/01/2022.
//

import SwiftUI

class AddSongViewModel: ObservableObject {

    // MARK: - Exposed properties

    @Published var songTitle: String = ""
    @Published var date = Date()
    @Published var rate: Int = 3
    @Published var isFavorite = false
    @Published var showAlert = false

    private(set) lazy var alertMessage: String = ""
    private(set) lazy var alertTitle: String = ""

    // MARK: - Public
    func addSong() {
        let songResult = DBManager.shared.addSong(
            title: songTitle,
            rate: Int64(rate),
            releaseDate: date,
            isFavorite: isFavorite,
            lyrics: "Bla bla bla bla",
            coverURL: URL(string: "https://api.lorem.space/image/album"))

        switch songResult {
        case .success(let song):
            handlerAlert(title: "Well Done", message: "Successfully added \(song.title ?? "song")")
        case .failure(let error):
            handlerAlert(title: "Error", message: error.localizedDescription)
        }
    }

    // MARK: - Private
    private func handlerAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert.toggle()
    }

}
