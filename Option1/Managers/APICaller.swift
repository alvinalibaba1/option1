//
//  APICalller.swift
//  Option1
//
//  Created by temp on 12/09/23.
//

import Foundation


enum idMovies: Int {
    case id
}

struct Constants  {
    static let API_KEY = "3651a4275e6ef581913cf914516b44e5"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyAfTyen3GpTiHxhZl6quk5iANKjHleU2Cg"
    static let youtubebaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedToGetData
}


class APICaller {
    static let shared = APICaller()
    
    
    func getGenreMovies(completion: @escaping  (Result<[Data], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=14&api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
               
                let results = try JSONDecoder().decode(GenreMoviesResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    
    func getActionMovies(completion: @escaping (Result<[Data],Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=28&api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data , _ , error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                
                let results = try JSONDecoder().decode(GenreMoviesResponse.self, from: data)
                completion(.success(results.results))
            
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
        
    }
    
    
    func getThrillerMovie(completion: @escaping (Result<[Data],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=36&api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(GenreMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getRomanceMovie(completion: @escaping (Result<[Data],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=10749&api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(GenreMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getWarMovie(completion: @escaping (Result<[Data],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=10752&api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(GenreMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getTopRatedMovie(completion: @escaping (Result<[Data],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?language=en-US&page=1&api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(GenreMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getFilterGenreMovie(with query: String, completion: @escaping (Result<[Data],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_genres=\(query)&api_key=\(query)\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(GenreMoviesResponse.self, from: data)
                completion(.success(results.results))
                print(results)
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.youtubebaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(YoutubeVideoResponse.self, from: data)
                completion(.success(results.items[0]))
                
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
            
    }
    
    func getGenreMovie(completion: @escaping (Result<[GenresFilm],Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/genre/movie/list?language=en&api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(Genre.self, from: data)
                completion(.success(results.genres))

            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    

    
    
    func getReviewMovie(idMovies: Int, completion: @escaping (Result<[ReviewsMovie], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/\(idMovies)/reviews?language=en-US&page=1&api_key=\(Constants.API_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _ , error in
            guard let data = data , error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(ReviewMoviesResponse.self, from: data)
                completion(.success(results.results))
                print(results)
                
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
            
    }
    
//https://api.themoviedb.org/3/movie/346698/reviews?language=en-US&page=1&api_key=3651a4275e6ef581913cf914516b44e5
    
}
