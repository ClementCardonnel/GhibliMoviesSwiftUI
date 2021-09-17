//
//  FilmCell.swift
//  FilmCell
//
//  Created by Clément Cardonnel on 03/09/2021.
//

import SwiftUI

struct FilmCell: View {
    let film: Film

    var body: some View {
        ZStack(alignment: .bottom) {
            if let image = film.cover {
                image
                    .resizable()
                    .scaledToFill()
            }

            VStack(spacing: 4) {
                Text(film.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(film.releaseDate.formatted())
                    .foregroundStyle(.secondary)
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(.regularMaterial)
        }
        .cornerRadius(16)
    }
}

struct FilmCell_Previews: PreviewProvider {
    static var previews: some View {
        FilmCell(film: .preview)
            .frame(width: 120, height: 300)
    }
}
