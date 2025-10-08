//
//  DetailView.swift
//  cine-track
//
//  Created by Laura Marson on 09/09/25.
//

import SwiftUI

struct DetailView: View {
    
    @State private var viewModel: DetailViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.movieDataManager) private var movieDataManager
    
    private let backDropSize: CGFloat = 375
    
    init(movie: Movie) {
        _viewModel = State(initialValue: DetailViewModel(movie: movie, movieDataManager: MovieDataManager()))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                // Back button and poster image
                ZStack(alignment: .topLeading) {
                    
                    // Background image
                    if let backdropPath = viewModel.movie.backdropPath {
                        Image.fromURL(imageAPIMedium + backdropPath)

                            .frame(height: backDropSize)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.black)
                            .frame(height: backDropSize)
                    }
             
                    // Gradient overlay
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.background]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: backDropSize)
                    
                    // Movie poster
                    VStack {
                        Spacer()
                        HStack {
                            if let posterPath = viewModel.movie.posterPath {
                                Image.fromURL(imageAPISmall + posterPath)
                                    .frame(width: 160, height: 240)
                                    .cornerRadius(12)
                                    .shadow(radius: 10)
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 160, height: 240)
                                    .cornerRadius(12)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                }
                
                // Movie info section
                VStack(alignment: .leading, spacing: 16) {
                    
                    movieTitle
                    movieDataSection
                    
                    // Action buttons
                    HStack(spacing: 12) {
                        
                        StateButton(
                            title: "Assistido",
                            isSelected: $viewModel.isWatchedButtonSelected,
                            action: { viewModel.handleState(incomingState: .watched) }
                        )
                        
                        StateButton(
                            title: "Assistir depois",
                            isSelected: $viewModel.isWatchLaterButtonSelected,
                            action: { viewModel.handleState(incomingState: .toWatch) }
                        )
                        
                    }
                    .padding(.horizontal, 20)
                    
                    synopsis
                    
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CustomBackButton()
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .background(Color.background)
        .ignoresSafeArea(.all, edges: .top)
        .toolbarBackground(.clear, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .onAppear {
            viewModel.setModelContext(modelContext)
        }
       
    }
    
    private var synopsis: some View {
        // Synopsis section
        VStack(alignment: .leading, spacing: 12) {
            Text("Sinopse")
                .font(.headline)
                .foregroundColor(.softWhite)
            
            Text(viewModel.movie.overview.isEmpty ? "Sem sinopse disponível." : viewModel.movie.overview)
                .font(.body)
                .foregroundColor(.softWhite.opacity(0.9))
                .lineLimit(nil)
                .padding(12)
                .background(Color.softWhite.opacity(0.1))
                .cornerRadius(8)
        }
        .padding(.horizontal, 20)
        .padding(.top, 24)
    }
    
    private var addToWatchLaterButton: some View {
       Button(action: {
           viewModel.handleState(incomingState: .toWatch)
        }) {
            HStack {
                Image(systemName: viewModel.isInWatchLater ? "checkmark" : "plus")
                Text(viewModel.isInWatchLater ? "Na lista" : "Assistir depois")
            }
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(viewModel.isInWatchLater ? Color.green : Color.blue)
            .cornerRadius(25)
        }
    }
    
    private func stateButton(
        title: String,
        incomingState: Movie.State
    ) -> some View {
        
        return Button(action: {
            viewModel.handleState(incomingState: incomingState)
        }) {
            HStack {
                Image(systemName: true ? "checkmark.circle" : "plus.circle")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.clear, Color.pink],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    
                Text(title)
                    .fontWeight(.bold)
            }
            .frame(height: 44)
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(Color.buttonBackground)
            .cornerRadius(25)
        }
    }
    
    private var movieTitle: some View {
        // Title
        Text(viewModel.movie.title)
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.softWhite)
            .padding(.horizontal, 20)
    }
    
    private var movieDataSection: some View {
        // Year, genre info
        HStack {
            Text(viewModel.movie.releaseYear)
                .fontWeight(.bold)
            Text("•")
            Text(viewModel.movie.mainGenre)
        }
        .font(.subheadline)
        .foregroundColor(.softWhite.opacity(0.8))
        .padding(.horizontal, 20)
    }
}

#if DEBUG
#Preview {
    DetailView(movie: batman)
}
#endif
