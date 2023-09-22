//
//  Movie.swift
//  Option1
//
//  Created by temp on 12/09/23.
//

import Foundation

struct GenreMoviesResponse: Codable {
    let results: [Data]
}

struct Data: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String
    let vote_average: Double
}
