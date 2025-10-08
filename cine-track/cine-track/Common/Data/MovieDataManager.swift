//
//  MovieDataManager.swift
//  cine-track
//
//  Created by Laura Marson on 09/09/25.
//

import Foundation
import SwiftData

@Observable
final class MovieDataManager {
    
    init() {
        
    }
    
    // MARK: - Add Operations
    
    func addMovie(_ movie: Movie, modelContext: ModelContext) {
        // Check if movie already exists by ID
        if !movieExists(withId: movie.id, modelContext: modelContext) {
            modelContext.insert(movie)
            saveContext(modelContext)
        }
    }
    
    func addMovieToWatched(_ movie: Movie, modelContext: ModelContext) {
        if let existingMovie = getMovie(withId: movie.id, modelContext: modelContext) {
            existingMovie.state = .watched
        } else {
            movie.state = .watched
            modelContext.insert(movie)
        }
        saveContext(modelContext)
    }
    
    func addMovieToWatchLater(_ movie: Movie, modelContext: ModelContext) {
        if let existingMovie = getMovie(withId: movie.id, modelContext: modelContext) {
            existingMovie.state = .toWatch
        } else {
            movie.state = .toWatch
            modelContext.insert(movie)
        }
        saveContext(modelContext)
    }
    
    // MARK: - Remove Operations
    
    func removeMovie(_ movie: Movie, modelContext: ModelContext) {
        if let existingMovie = getMovie(withId: movie.id, modelContext: modelContext) {
            modelContext.delete(existingMovie)
            saveContext(modelContext)
        }
    }
    
    // MARK: - Query Operations
    
    func getWatchedMovies(modelContext: ModelContext) -> [Movie] {
        let descriptor = FetchDescriptor<Movie>()
        do {
            let allMovies = try modelContext.fetch(descriptor)
            return allMovies.filter { $0.state == .watched }
        } catch {
            print("Failed to fetch watched movies: \(error)")
            return []
        }
    }
    
    func getWatchLaterMovies(modelContext: ModelContext) -> [Movie] {
        let descriptor = FetchDescriptor<Movie>()
        do {
            let allMovies = try modelContext.fetch(descriptor)
            return allMovies.filter { $0.state == .toWatch }
        } catch {
            print("Failed to fetch watch later movies: \(error)")
            return []
        }
    }
    
    func getMovie(withId id: Int, modelContext: ModelContext) -> Movie? {
        let descriptor = FetchDescriptor<Movie>(
            predicate: #Predicate { $0.id == id }
        )
        return try? modelContext.fetch(descriptor).first
    }
    
    func movieExists(withId id: Int, modelContext: ModelContext) -> Bool {
        getMovie(withId: id, modelContext: modelContext) != nil
    }
    
    func getMovieState(withId id: Int, modelContext: ModelContext) -> Movie.State {
        return getMovie(withId: id, modelContext: modelContext)?.state ?? .unknown
    }
    
    // MARK: - Update Operations
    
    func updateMovieState(_ movie: Movie, to state: Movie.State, modelContext: ModelContext) {
        if let existingMovie = getMovie(withId: movie.id, modelContext: modelContext) {
            existingMovie.state = state
            saveContext(modelContext)
        }
    }
    
    func toggleMovieWatchedState(_ movie: Movie, modelContext: ModelContext) {
        if let existingMovie = getMovie(withId: movie.id, modelContext: modelContext) {
            existingMovie.state = existingMovie.state == .watched ? .unknown : .watched
        } else {
            movie.state = .watched
            modelContext.insert(movie)
        }
        saveContext(modelContext)
    }
    
    func toggleMovieWatchLaterState(_ movie: Movie, modelContext: ModelContext) {
        if let existingMovie = getMovie(withId: movie.id, modelContext: modelContext) {
            existingMovie.state = existingMovie.state == .toWatch ? .unknown : .toWatch
        } else {
            movie.state = .toWatch
            modelContext.insert(movie)
        }
        saveContext(modelContext)
    }
    
    // MARK: - Private Helpers
    
    private func saveContext(_ modelContext: ModelContext) {
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
