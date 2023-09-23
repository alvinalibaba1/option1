//
//  GenreViewController.swift
//  Option1
//
//  Created by temp on 08/09/23.
//

import UIKit

class GenreViewController: UIViewController, GenresViewControllerDelegate {
    
    private var data: [Data] = [Data]()
    
    var movies = [[String:Any]]()
    
    private let genreViewTable: UITableView = {
        
        let table = UITableView()
        table.register((MoviesGenreTableViewCell.self), forCellReuseIdentifier: MoviesGenreTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Genres", style: .plain, target: self, action: #selector(genreFilter))
        
        
        view.addSubview(genreViewTable)
        genreViewTable.delegate = self
        genreViewTable.dataSource = self
        fetchMovies()
        
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        genreViewTable.frame = view.bounds
        
        
    }
    
    
    @objc private func genreFilter() {
        let vc = FilterGenreViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func fetchMovies() {
        APICaller.shared.getTopRatedMovie { [weak self] result in
            switch result {
            case .success(let data):
                self?.data = data
                DispatchQueue.main.async {
                    self?.genreViewTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
//    func performFilterRequest(with url: URL) {
//        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 10)
//        let session = URLSession(configuration: .default , delegate: nil, delegateQueue: OperationQueue.main)
//        let task = session.dataTask(with: request) { ( data, response, error) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let data = data {
//                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
//                self.movies = dataDictionary["results"] as! [[String:Any]]
//                self.genreViewTable.reloadData()
//            }
//        }
//        task.resume()
//    }
//
//    func filterURL(filterText: String) -> URL {
//        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=cc1dd3075ce8f7e82e9d87cc00aa19d2&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&with_genres=" + filterText)
//        return url!
//    }
}


extension GenreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesGenreTableViewCell.identifier, for: indexPath) as? MoviesGenreTableViewCell else {
            return UITableViewCell()
        }
        
        let data = data[indexPath.row]
        cell.configure(with: MoviesGenreViewModel(moviesName: (data.original_name ?? data.original_title) ?? "Uknown", posterURL: data.poster_path ?? ""))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
}
