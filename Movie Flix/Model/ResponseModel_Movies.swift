//
//  ResponseModel_Movies.swift
//  Movie Flix
//
//  Created by sweta makuwala on 05/06/24.
//

import Foundation
// MARK: - Movie
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movies = try? JSONDecoder().decode(Movies.self, from: jsonData)

import Foundation

// MARK: - Movie
struct Movie: Decodable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let videoUrl : String
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case videoUrl = "video_url"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case zh = "zh"
}

typealias Movies = [Movie]
