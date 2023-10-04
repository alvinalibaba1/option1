//
//  ReviewMovie.swift
//  Option1
//
//  Created by temp on 25/09/23.
//

import Foundation


struct ReviewMoviesResponse: Codable {
    let results: [ReviewsMovie]
}

struct ReviewsMovie: Codable {
    let author: String?
    let content: String?
    
}
