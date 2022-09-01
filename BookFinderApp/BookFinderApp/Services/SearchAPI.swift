//
//  SearchAPI.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/1/22.
//

import Foundation

enum SearchAPI {
    case search(String)
    
    private static let baseURL = "https://www.googleapis.com/books/v1"
    
    var url: URL {
        return URL(string: SearchAPI.baseURL)!
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "/volumes"
        }
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .search(let query):
            return [URLQueryItem(name: "q", value: query)]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: SearchAPI.baseURL)!.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = query
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }
}
