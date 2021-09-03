//
//  ContentView.swift
//  GhibliMoviesSwiftUI
//
//  Created by Clément Cardonnel on 03/09/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var filmViewModel = FilmViewModel()

    let columns: [GridItem] = {
        let item = GridItem(.adaptive(minimum: 130))
        return [item]
    }()

    var body: some View {
        NavigationView {
            // The first View inside the NavigationView is the Master
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(filmViewModel.films) { film in
                        NavigationLink(destination: FilmDetailView(film: film)) {
                            FilmCell(film: film)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Ghibli Movies")
            .task {
                filmViewModel.fetchNewFilms()
            }

            // The second View is the Detail
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
