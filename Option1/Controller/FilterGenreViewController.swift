//
//  FilterGenreViewController.swift
//  Option1
//
//  Created by temp on 21/09/23.
//

import Foundation
import UIKit

@objc protocol GenresViewControllerDelegate {
    @objc optional func genresViewController(genresViewController: FilterGenreViewController, selectedGenre genre: String)
}

class FilterGenreViewController: UIViewController{
    
    weak var delegate: GenresViewControllerDelegate?
    
    private var data: [MoviesResponse] = [MoviesResponse]()
    
    private var genres: [GenresFilm ] = [GenresFilm]()
    
    
    private let tableGenre: UITableView = {
        let table = UITableView()
        table.register(FilterGenreTableViewCell.self, forCellReuseIdentifier: FilterGenreTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableGenre)
        tableGenre.delegate = self
        tableGenre.dataSource = self
        
//        genres = genresList()
    
        fetchGenre()
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableGenre.frame = view.bounds
    }
    
    
    func fetchGenre() {
        
        APICaller.shared.getGenreMovie { [weak self] result in
            switch result {
            case .success(let data):
                self?.genres = data
                DispatchQueue.main.async {
                    self?.tableGenre.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
//    func genresList() -> [[String:String]] {
//        return [["name": "All", "id":""],
//                ["name": "Action", "id":"28"],
//                ["name": "Adventure", "id":"12"],
//                ["name": "Animation", "id":"16"],
//                ["name": "Comedy", "id":"35"],
//                ["name": "Documentary", "id":"99"],
//                ["name": "Drama", "id":"18"],
//                ["name": "Family", "id":"10751"],
//                ["name": "Fantasy", "id":"14"],
//                ["name": "Horror", "id":"27"],
//                ["name": "Music", "id":"10402"],
//                ["name": "Mystery", "id":"9648"],
//                ["name": "Romance", "id":"10749"],
//                ["name": "Science Fiction", "id":"878"],
//                ["name": "Thriller", "id":"53"]]
//    }
}

extension FilterGenreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterGenreTableViewCell.identifier, for: indexPath) as? FilterGenreTableViewCell else {
            return UITableViewCell()
        }
        
        let genre = genres[indexPath.row]
        cell.genresLabel.text = genre.name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = data[indexPath.row]
        
//        let genre = genres[indexPath.row]["id"]!
        
        guard let titleName = data.original_title ?? data.original_name else {
            return
        }
//        
//        APICaller.shared.getFilterGenreMovie(with: genre) { result in
//            switch result {
//            case .success(let pickGenre):
//                print(genres.id)
//            case .failure(let error):
//                print()
//            }
//        }

        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        
        
//        delegate?.genresViewController?(genresViewController: self, selectedGenre: genres)
        
        dismiss(animated: true, completion: nil)
    }
}
