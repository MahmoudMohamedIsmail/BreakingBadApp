//
//  BaseError.swift
//
//

import Foundation

enum ServiceError: Int, Error{
    
    case connectionError = 408 //Connection Time out
    case authorizationError = 401 //Unauthorized
    case invalidRequest = 502 //Bad Gateway
    case notFound = 404 // Not Found
    case serverError = 500 //Internal Server Error
    case serverConnection = 504 //Gateway Timeout
    case serviceUnavailable = 503 //Service Unavailable
    case noResponse = 444 //No Response

    var localizedDescription: String {
        switch self{
        case .connectionError:
            return "Check your Internet connection."
        case .invalidRequest:
            return "Failed to connect to the server."
        case .authorizationError:
            return "Session Has Expired."
        case .serverConnection:
            return "Problem connecting to server, Check your Internet connection and try again."
        default:
            return ""
        }
    }
}

struct AppError {
    var message: String

    init(message: String) {
        self.message = message
    }
}

extension AppError: LocalizedError {
    var errorDescription: String? { return message }
}
