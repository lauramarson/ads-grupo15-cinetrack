//
//  ImageExtension.swift
//  cine-track
//
//  Created by Laura Marson on 08/09/25.
//

import SwiftUI
import CachedAsyncImage

extension Image {
    
    static func fromURL(_ urlString: String,
                        placeholder: Image = Image(.placeholder),
                        errorImage: Image = Image(.notFound)) -> some View {
        CachedAsyncImage(url: URL(string: urlString), urlCache: .imageCache) { phase in
            switch phase {
            case .empty:
                placeholder
                    .resizable()
            case .success(let image):
                image
                    .resizable()
            case .failure(_):
                errorImage
                    .resizable()
            @unknown default:
                errorImage
                    .resizable()
            }
        }
    }
    
}
