import Foundation

// MARK: - Network Error Types

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError(Error)
    case httpError(Int, String?)
    case networkError(Error)
    case invalidResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .httpError(let code, let message):
            return "HTTP error \(code): \(message ?? "Unknown error")"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response"
        }
    }
}

// MARK: - HTTP Method

enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}


// MARK: - Response Data

struct Response<T: Decodable> {
    
    var result: Result<T, NetworkError>
    var urlRequest: URLRequest
    var httpResponse: HTTPURLResponse?
    
    static func failure(error: NetworkError, urlRequest: URLRequest, httpResponse: HTTPURLResponse? = nil) -> Self {
        Response(result: .failure(error), urlRequest: urlRequest, httpResponse: httpResponse)
    }
    
    static func success(object: T, urlRequest: URLRequest, httpResponse: HTTPURLResponse?) -> Self {
        Response(result: .success(object), urlRequest: urlRequest, httpResponse: httpResponse)
    }
    
}

struct MovieResponse: Codable {
    let results: [Movie]
}

// MARK: - Requests

struct GetMovieRequest: NetworkRequest {
    
    typealias ResponseType = MovieResponse
    
    let url: URL
    let method: HTTPMethod = .GET
    let headers: [String: String]? = nil
    let body: Data? = nil
    
    init(name: String) {
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name
        self.url = URL(string: baseAPI + "/search/movie?query=\(encodedName)")!
    }
}

struct PopularMoviesRequest: NetworkRequest {
    
    typealias ResponseType = MovieResponse
    
    var url: URL = URL(string: baseAPI + "/discover/movie")!
    let method: HTTPMethod = .GET
    let headers: [String: String]? = nil
    let body: Data? = nil
 
    init(page: Int = 1) {
        url.append(queryItems: [
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
        ])
    }
    
}

