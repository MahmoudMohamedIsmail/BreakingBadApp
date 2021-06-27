//
//  Constant.swift
//
//

import Foundation
import UIKit


struct Constants{
    static let baseURL = "https://www.breakingbadapi.com/api/"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case acceptLanguage = "Accept-Language"
}

enum ContentType: String {
    case json = "application/x-www-form-urlencoded; charset=utf-8"
    case applicationJson = "application/json"
    case accept = "*/*"
    case acceptEncoding = "gzip;q=1.0, compress;q=0.5"
    case multipart = "multipart/form-data"
}
