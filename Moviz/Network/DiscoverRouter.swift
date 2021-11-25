//
//  DiscoverRouter.swift
//  Moviz
//
//  Created by Li Hao Lai on 25/11/20.
//

import Foundation
import Alamofire

enum DiscoverRouter: URLRequestConvertible {
    case movie

    var host: String {
        "https://api.themoviedb.org"
    }

    var method: HTTPMethod {
        switch self {
        case .movie: return .get
        }
    }

    var path: String {
        switch self {
        case .movie: return "3/discover/movie"
        }
    }

    var query: [String: String]? {
        switch self {
        case .movie:
            return [
                "api_key": "5d0d27b4a1c9f83be70c6d110c345f83",
                "language": "en-US",
                "sort_by": "popularity.desc",
                "include_adult": "false",
                "include_video": "true",
                "page": "1"
            ]
        }
    }

    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: host),
              let apiUrl = URL(string: path, relativeTo: url),
              var urlComponents = URLComponents(url: apiUrl, resolvingAgainstBaseURL: true) else {
            throw AFError.invalidURL(url: host)
        }

        urlComponents.queryItems = query?.map { URLQueryItem(name: $0, value: $1) }

        guard let urlComponentsURL = urlComponents.url else {
          throw AFError.invalidURL(url: path)
        }

        var request = URLRequest(url: urlComponentsURL)
        request.method = method

        return request
    }
}
