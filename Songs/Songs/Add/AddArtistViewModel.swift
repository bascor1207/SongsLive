//
//  AddSongViewModel.swift
//  SongsLive
//
//  Created by Sascha Sallès on 19/01/2022.
//

import SwiftUI

class AddArtistViewModel: ObservableObject {

    // MARK: - Exposed properties

    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var showAlert = false

    private(set) lazy var alertMessage: String = ""
    private(set) lazy var alertTitle: String = ""

    // MARK: - Public
    func addArtist() {
        let artistResult = DBManager.shared.addArtist(
            firstName: firstName,
            lastName: lastName,
            coverURL: URL(string: "https://api.lorem.space/image/album"))

        switch artistResult {
        case .success(let artist):
            handlerAlert(title: "Well Done", message: "Successfully added \(artist.firstName! + "" + artist.lastName!)")
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
