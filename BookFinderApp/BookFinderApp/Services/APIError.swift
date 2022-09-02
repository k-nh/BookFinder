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
    
    func toErrorMessage() -> String {
        switch self {
        case .errorDescription:
            return "네트워크 관련 오류가 발생했습니다. 잠시 후 다시 시도해주세요."
        case .noDataError:
            return "해당 데이터가 존재하지 않습니다."
        case .decodeError:
            return "네트워크 관련 오류가 발생했습니다."
        case .unknownError:
            return "오류가 발생했습니다. 잠시 후 다시 시도해주세요."
        }
    }
}
