//
//  Router.swift
//  IMDBApp
//
//  Created by Esin Esen on 26.04.2022.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    static let apiKey = "c1681222ccbab38a3827a02c956a53fa"
    
    case upcoming
    case nowPlaying
    case search(searchText: String)
    case detail(movieId: Int)
    case similar(movieId: Int)
    
    var baseURL : URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .upcoming, .nowPlaying, .search, .detail, .similar:
            return .get
        }
    }
    
    var parameters: [String: Any]? {

        switch self {
        case .upcoming:
            return nil
        case .nowPlaying:
            return nil
        case .search(let text):
            return ["query": text]
        case .detail:
            return nil
        case .similar:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var path: String {
        switch self {
        case .upcoming:
            return "/movie/upcoming"
        case .nowPlaying:
            return "/movie/now_playing"
        case .search:
            return "/search/movie"
        case .detail(movieId: let movieID):
            return "/movie/\(movieID)"
        case .similar(movieId: let movieID):
            return "/movie/\(movieID)/similar"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        var completeParameters = parameters ?? [:]
        
        completeParameters["api_key"] = Router.apiKey
        
        let urlRequestPrint = try encoding.encode(urlRequest, with: completeParameters)
        debugPrint("************> MY URL: ", urlRequestPrint.url ?? "")
        
        return try encoding.encode(urlRequest, with: completeParameters)
    }
}
