//
//  SearchViewModel.swift
//  cine-track
//
//  Created by Laura Marson on 08/09/25.
//

import Combine
import Foundation

enum SearchState {
    case idle
    case loading
    case loaded([Movie])
    case empty
    case error(String)
}

@MainActor
class SearchViewModel: ObservableObject {

    @Published var state: SearchState = .idle
    @Published var searchText: String = ""
    private var service: ClientAPI
    private var cancellables: Set<AnyCancellable> = []
    private var popularMovies: [Movie] = []
    
    init(service: ClientAPI) {
        self.service = service
        setupObservables()
    }
    
    private func setupObservables() {
        $searchText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                guard let self else { return }

                if searchText.isEmpty {
                    restorePopularMovies()
                } else {
                    Task {
                        await self.fetchMovie(name: searchText)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchPopularMovies() async {
        guard case .idle = state else { return }
        state = .loading
        let response = await service.popular()
        switch response.result {
        case .success(let result):
            var movies = result.results
            state = .loaded(movies)
        case .failure(let error):
            state = .error(error.errorDescription ?? "Error")
        }
    }
    
    func fetchMovie(name: String) async {
        state = .loading
        let response = await service.movie(name: searchText)
        switch response.result {
        case .success(let result):
            let movies = result.results
            state = movies.isEmpty ? .empty : .loaded(movies)
        case .failure(let error):
            state = .error(error.errorDescription ?? "Error")
        }
    }

    private func restorePopularMovies() {
        if !popularMovies.isEmpty {
            state = .loaded(popularMovies)
        }
    }

}
