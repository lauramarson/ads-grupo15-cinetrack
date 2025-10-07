//
//  DetailViewModel.swift
//  cine-track
//
//  Created by Laura Marson on 09/09/25.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
final class DetailViewModel {

    private let movieDataManager: MovieDataManager
    
    @Published
    var movie: Movie
    
    @Published
    var isWatchedButtonSelected: Bool = false
    
    @Published
    var isWatchLaterButtonSelected: Bool = false
    
    private var modelContext: ModelContext?
    
    init(movie: Movie, movieDataManager: MovieDataManager) {
        self.movie = movie
        self.movieDataManager = movieDataManager
        self.handleButtonsState()
    }
    
    var isInWatchLater: Bool {
        movie.state == .toWatch
    }
    
    var isWatched: Bool {
        movie.state == .watched
    }
    
    // MARK: - Actions
    private func handleButtonsState() {
        isWatchedButtonSelected = movie.state == .watched
        isWatchLaterButtonSelected = movie.state == .toWatch
    }
    
    func setModelContext(_ modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func handleState(incomingState: Movie.State) {
        let previousState = movie.state
        
        defer { handleButtonsState() }
        
        guard incomingState != previousState else {
            removeFromList()
            movie.state = .unknown
            return
        }
        
        switch incomingState {
        case .watched:
            removeFromList()
            addToWatched()
        case .toWatch:
            removeFromList()
            addToWatchLater()
        default:
            break
        }
        
        movie.state = incomingState
    }

    func addToWatched() {
        guard let modelContext else { return }
        movieDataManager.addMovieToWatched(movie, modelContext: modelContext)
    }
    
    func addToWatchLater() {
        guard let modelContext else { return }
        movieDataManager.addMovieToWatchLater(movie, modelContext: modelContext)
    }
    
    func removeFromList() {
        guard let modelContext else { return }
        movie.state = .unknown
        movieDataManager.removeMovie(movie, modelContext: modelContext)
    }
    
}
