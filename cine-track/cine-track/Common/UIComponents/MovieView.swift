//
//  MovieView.swift
//  cine-track
//
//  Created by Laura Marson on 08/09/25.
//

import SwiftUI

struct MovieView: View {
    
    @State var movie: Movie
    
    var body: some View {
        
        
        ZStack(alignment: .topTrailing) {
            
            VStack {
       
                Image.fromURL(imageAPISmall + (movie.posterPath ?? ""))
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(movie.title)
                        .font(.callout)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(movie.releaseYear + " • " + movie.mainGenre)
                        .font(.caption)
                        .monospaced()
                    
                }
                .frame(height: 70)
                .padding(.leading, 4)
                
            }
            
            if movie.averageScore != "0.0" {
                Text(movie.averageScore)
                    .foregroundColor(.black)
                    .font(.caption)
                    .padding(8)
                    .background(Circle().fill(Color.softWhite.opacity(0.7)))
                    .frame(width: 40, height: 40)
                    .padding(2)
            }
            
        }
        .padding(.bottom, 6)
        .background(Color.softWhite.opacity(0.8))
        .cornerRadius(8)
    }
    
}

#Preview {
    MovieView(movie: batmanPuppetMaster)
        .frame(width: 175, height: 225)
}
