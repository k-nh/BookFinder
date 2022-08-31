//
//  GoogleBookRequestManager.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/1/22.
//

import Foundation
import Alamofire

enum GoogleBookRequestManager: URLRequestConvertible {
    case search(String)

    var baseURL: String {
        return "https://www.googleapis.com/books/v1"
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
        let url = try baseURL.asURL().appendingPathComponent(path)
        var urlRequest = try URLRequest(url: url, method: method)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = query
        urlRequest.url = components?.url

        return urlRequest
    }
}
