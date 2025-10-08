import Foundation

protocol ClientAPI {
    func movie(name: String) async -> Response<GetMovieRequest.ResponseType>
    func popular() async -> Response<PopularMoviesRequest.ResponseType>
}

final class MoviesApi: ClientAPI {
    
    private let networkService = NetworkService()
    
    func movie(name: String) async -> Response<GetMovieRequest.ResponseType> {
        let request: GetMovieRequest = GetMovieRequest(name: name)
        return await networkService.execute(request)
    }
    
    func popular() async -> Response<PopularMoviesRequest.ResponseType> {
        let request: PopularMoviesRequest = PopularMoviesRequest()
        return await networkService.execute(request)
    }
    
}

#if DEBUG

final class MockApiClient: ClientAPI {
    
    func movie(name: String) async -> Response<GetMovieRequest.ResponseType> {
        let object: [Movie] = [batman, batmanVersus]
        let response: MovieResponse = MovieResponse(results: object)
        let url: URL = URL(string: baseAPI)!
        let urlRequest: URLRequest = URLRequest(url: url)
        return .success(object: response, urlRequest: urlRequest, httpResponse: nil)
    }
    
    func popular() async -> Response<PopularMoviesRequest.ResponseType> {
        let object: [Movie] = [batman, batmanVersus, batmanPuppetMaster]
        let response: MovieResponse = MovieResponse(results: object)
        let url: URL = URL(string: baseAPI)!
        let urlRequest: URLRequest = URLRequest(url: url)
        return .success(object: response, urlRequest: urlRequest, httpResponse: nil)
    }
    
}

#endif
