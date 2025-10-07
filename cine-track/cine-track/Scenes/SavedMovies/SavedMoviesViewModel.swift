//
//  SavedMoviesViewModel.swift
//  cine-track
//
//  Created by Laura Marson on 09/09/25.
//

import Foundation
import SwiftData

@Observable
final class SavedMoviesViewModel {
    
    private let movieType: Movie.State
    private let movieDataManager: MovieDataManager
    private var modelContext: ModelContext?
    
    var title: String {
        movieType == .toWatch ? "Assistir depois" : "Assistidos"
    }
    var watchedMovies: [Movie] = []
    
    init(movieDataManager: MovieDataManager, movieType: Movie.State) {
        self.movieDataManager = movieDataManager
        self.movieType = movieType
    }
    
    func setModelContext(_ modelContext: ModelContext) {
        self.modelContext = modelContext
        loadMovies()
    }
    
    func loadMovies() {
        guard let modelContext else { return }
        
        let descriptor = FetchDescriptor<Movie>()
        do {
            let allMovies = try modelContext.fetch(descriptor)
            watchedMovies = allMovies.filter { $0.state == movieType }
        } catch {
            print("Failed to load watched movies: \(error)")
            watchedMovies = []
        }
    }
    
    func deleteMovie(_ movie: Movie) {
        guard let modelContext else { return }
        movieDataManager.removeMovie(movie, modelContext: modelContext)
        loadMovies()
    }
    
    func getContentUnavailableInfo() -> (title: String, description: String) {
        let title: String
        let description: String
        
        switch movieType {
        case .watched:
            title = "Nenhum filme assistido"
            description = "Os filmes que você marcar como assistidos aparecerão aqui."
        case .toWatch:
            title = "Nenhum filme salvo para assistir depois"
            description = "Os filmes que você salvar para assistir depois aparecerão aqui."
        case .unknown:
            title = "Nenhum filme encontrado"
            description = "Não há filmes nesta lista no momento."
        }
        
        return (title, description)
    }
}
