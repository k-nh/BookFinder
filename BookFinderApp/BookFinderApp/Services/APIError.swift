//
//  APIError.swift
//  BookFinderApp
//
//  Created by 김나희 on 9/2/22.
//

import Foundation

enum APIError: LocalizedError {
    case errorDescription(statusCode: Int)
    case noDataError
    case decodeError
    case unknownError
}
