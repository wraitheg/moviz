//
//  MovieList.swift
//  Moviz
//
//  Created by Li Hao Lai on 6/12/20.
//

import Foundation

struct MovieList: Codable {
    let page: Int
    let results: [Movie]
}

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
