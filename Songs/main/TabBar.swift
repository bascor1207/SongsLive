//
//  ContentView.swift
//  SongsLive
//
//  Created by Sascha Sallès on 19/01/2022.
//

import SwiftUI

struct TabBar: View {
    @State private var selection: Int = 0

    var body: some View {
        TabView(selection: $selection) {
            SongsView()
                .tabItem { Label("Songs", systemImage: "music.note.list")}
                .tag(0)
            FavsView()
                .tabItem { Label("Favorites", systemImage: "star")}
                .tag(1)
        }.onAppear {
            DispatchQueue.main.async {
                DBManager.shared.addDefaultArtist()
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
