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
    
    let genres: GenresFilm
    
    init(youtubeView: VideoElement, movie: MoviesResponse, genres: GenresFilm) {
        self.youtubeView = youtubeView
        self.movie = movie
        self.genres = genres
    }
}
