//
//  SavedMovies.swift
//  cine-track
//
//  Created by Laura Marson on 08/09/25.
//

import SwiftUI
import SwiftData

struct SavedMovies: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: SavedMoviesViewModel
    
    init(_ movieType: Movie.State) {
        self._viewModel = State(initialValue: SavedMoviesViewModel(
            movieDataManager: MovieDataManager(),
            movieType: movieType)
        )
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.watchedMovies.isEmpty {
                    contentUnavailableView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                            ForEach(viewModel.watchedMovies) { movie in
                                NavigationLink(destination: DetailView(movie: movie)
                                    .onDisappear {
                                        viewModel.loadMovies()
                                    }
                                ) {
                                    MovieView(movie: movie)
                                        .frame(height: 290)
                                }
                                .foregroundStyle(Color.black)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.large)
            .background(Color.background)
        }
        .onAppear {
            viewModel.setModelContext(modelContext)
            viewModel.loadMovies()
        }
        .refreshable {
            viewModel.loadMovies()
        }
    }
    
    private func contentUnavailableView() -> some View {
        let contentUnavailableInfo = viewModel.getContentUnavailableInfo()
        
        return ContentUnavailableView(
            contentUnavailableInfo.title,
            systemImage: "tv.slash",
            description: Text(contentUnavailableInfo.description)
        )
        .foregroundStyle(Color.softWhite)
    }
}

#if DEBUG
#Preview {
    SavedMovies(.watched)
}
#endif
