//
//  BlurredBackground.swift
//  BlurredBackground
//
//  Created by Clément Cardonnel on 03/09/2021.
//

import SwiftUI

struct BlurredBackground: View {
    let cover: UIImage?

    var body: some View {
        if let cover = cover {
            Image(uiImage: cover)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .overlay(.regularMaterial)
        } else {
            EmptyView()
        }
    }
}

struct BlurredBackground_Previews: PreviewProvider {
    static var previews: some View {
        BlurredBackground(cover: Film.preview.cover)
    }
}
