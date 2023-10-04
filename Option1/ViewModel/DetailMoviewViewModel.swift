//
//  DetailMoviewViewModel.swift
//  Option1
//
//  Created by temp on 21/09/23.
//

import Foundation


class DetailMovieViewModel {
    let youtubeView: VideoElement
    
    let movie: MoviesResponse
    
    
    init(youtubeView: VideoElement, movie: MoviesResponse) {
        self.youtubeView = youtubeView
        self.movie = movie
    }
}
