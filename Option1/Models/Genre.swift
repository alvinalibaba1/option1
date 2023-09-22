//
//  Genre.swift
//  Option1
//
//  Created by temp on 22/09/23.
//

import Foundation

struct Genre: Codable{
    let genres: [GenresFilm]
}

struct GenresFilm: Codable {
    let id: Int
    let name: String
}
