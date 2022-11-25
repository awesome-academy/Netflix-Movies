//
//  Movie.swift
//  Netflix Movies
//
//  Created by Khanh on 18/11/2022.
//

import Foundation

struct TitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let mediaType: String?
    let originalName: String?
    let originalTitle: String?
    let posterPath: String?
    let overview: String?
    let vote_count: Int
    let releaseDate: String?
    let vote_average: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case overview
        case vote_count
        case releaseDate = "release_date"
        case vote_average
    }
}

