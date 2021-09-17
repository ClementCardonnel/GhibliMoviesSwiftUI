//
//  FilmDetailView.swift
//  FilmDetailView
//
//  Created by Clément Cardonnel on 03/09/2021.
//

import SwiftUI

struct FilmDetailView: View {
    let film: Film

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                if let cover = film.cover {
                    Image(uiImage: cover)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 300)
                        .clipped()
                }

                VStack(spacing: 8) {
                    Text(film.title)
                        .font(.title)
                        .foregroundStyle(.primary)

                    if let releaseDate = film.formattedReleaseDate {
                        Text(releaseDate)
                            .foregroundStyle(.primary)
                    }
                }

                Text(film.description)
                    .foregroundStyle(.secondary)

                HStack {
                    Spacer()
                    VStack {
                        Text("Producer")
                            .font(.subheadline)
                            .foregroundStyle(.tertiary)
                        Text(film.producer)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    VStack {
                        Text("Director")
                            .font(.subheadline)
                            .foregroundStyle(.tertiary)
                        Text(film.director)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .background(BlurredBackground(cover: film.cover))
        .navigationTitle(film.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FilmDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilmDetailView(film: .preview)
            .previewDevice("iPod touch (7th generation)")
    }
}
