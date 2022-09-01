//
//  SearchAPIProvider.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/1/22.
//

import Foundation

protocol SearchSearvice {
    func search(keyword: String, completion: @escaping (Result<GoogleBookData, Error>) -> Void)
}

class SearchAPIProvider: SearchSearvice {
    let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func search(keyword: String, completion: @escaping (Result<GoogleBookData, Error>) -> Void) {
        guard let request = try? SearchAPI.search(keyword).asURLRequest() else {
            return
        }
        
        let task: URLSessionDataTask = session
            .dataTask(with: request) { data, response, error in
                if let response = response as? HTTPURLResponse,
                    !(200...299).contains(response.statusCode) {
                    completion(.failure(APIError.errorDescription(statusCode: response.statusCode)))
                    return
                }

                guard let data = data else {
                    completion(.failure(APIError.noDataError))
                    return
                }
                
                guard let response = try? JSONDecoder().decode(GoogleBookData.self, from: data) else {
                    completion(.failure(APIError.decodeError))
                    return
                }
                
                completion(.success(response))
            }
        
        task.resume()
    }
}
