//
//  SearchView.swift
//  cine-track
//
//  Created by Laura Marson on 08/09/25.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel: SearchViewModel
    
    init() {
        // Lazy injection
        _viewModel = StateObject(wrappedValue: SearchViewModel(service: MoviesApi()))
    }
    
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle:
                    contentUnavailableView(title: "Buscar", systemImage: "magnifyingglass", description: "Busque filmes")
                case .loading:
                    ProgressView("Buscando...")
                case .loaded(let movies):
                    ScrollView {
                        LazyVGrid(
                            columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 8) {
                            ForEach(movies) { movie in
                                NavigationLink(destination: DetailView(movie: movie)) {
                                    MovieView(movie: movie)
                                        .frame(height: 290)
                                }.foregroundStyle(Color.black)
                            }
                        }
                            .padding(.horizontal, 8)
                    }
                    .background(Color.background)
                case .empty:
                    VStack(spacing: 16) {
                        Image("notFound")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                        Text("Nenhum filme encontrado")
                            .font(.title2)
                            .foregroundColor(.softWhite)
                        Text("Tente buscar com outros termos")
                            .font(.body)
                            .foregroundColor(.softWhite.opacity(0.7))
                    }
                case .error(let message):
                    ContentUnavailableView("Erro", systemImage: "exclamationmark.triangle", description: Text(message))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .searchable(text: $viewModel.searchText, prompt: "Buscar filmes...")
            .accentColor(.softWhite)
            .foregroundColor(.softWhite)
            .navigationTitle("CINETrack")
            .navigationBarTitleDisplayMode(.large)
            .background(Color.background)
        }.task {
            await viewModel.fetchPopularMovies()
        }
        
    }
    
    private func contentUnavailableView(title: String, systemImage: String, description: String) -> some View {
        ContentUnavailableView(
            title,
            systemImage: systemImage,
            description: Text(description)
        ).foregroundStyle(Color.softWhite)
    }
    
}

#Preview {
    SearchView()
        .environment(\.clientAPI, MockApiClient())
}
