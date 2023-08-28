//
//  VideoAPI.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import Alamofire

enum VideoAPI: APIable {
    
    case fetchPopularMovies(page: Int)
    case fetchMovieDetail(id: Int)
    case fetchPopularTVSeries(page: Int)
    
    var url: String {
        let baseURL = Endpoint.baseURL
        
        switch self {
        case let .fetchPopularMovies(page):
            return baseURL+"/movie/popular?page=\(page)"
        case let.fetchMovieDetail(id):
            return baseURL+"/movie/\(id)"
        case let .fetchPopularTVSeries(page):
            return baseURL+"/tv/popular?page=\(page)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchPopularMovies:       return .get
        case .fetchMovieDetail:         return .get
        case .fetchPopularTVSeries:     return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        default:                        return nil
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:                        return [Headers.accept, Headers.authorization]
        }
    }
    
    var request: DataRequest {
        return AF.request(
            self.url,
            method: self.method,
            parameters: self.parameters,
            headers: self.headers
        )
        .validate()
    }
}
