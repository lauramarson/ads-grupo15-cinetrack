//
//  WeatherServiceKey.swift
//  cine-track
//
//  Created by Laura Marson on 09/09/25.
//

import SwiftUI

// MARK: - API Service
private struct APIServiceKey: EnvironmentKey {
    static let defaultValue: ClientAPI = MoviesApi()
}

extension EnvironmentValues {
    var clientAPI: ClientAPI {
        get { self[APIServiceKey.self] }
        set { self[APIServiceKey.self] = newValue }
    }
}

// MARK: - MovieDataManager

struct MovieDataManagerKey: EnvironmentKey {
    static let defaultValue: MovieDataManager = MovieDataManager()
}

extension EnvironmentValues {
    var movieDataManager: MovieDataManager {
        get { self[MovieDataManagerKey.self] }
        set { self[MovieDataManagerKey.self] = newValue }
    }
}
