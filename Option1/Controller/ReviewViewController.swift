//
//  ReviewViewController.swift
//  Option1
//
//  Created by temp on 26/09/23.
//

import UIKit

class ReviewViewController: UIViewController {
    
    var movieID: Int
    
        
    var review: [ReviewsMovie] = [ReviewsMovie]()
    
    weak var delegate2: CollectionViewTableViewCellDelegate?
    
    init(movieID: Int, delegate2: CollectionViewTableViewCellDelegate? = nil) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let reviewTable: UITableView = {
        let table = UITableView()
        table.register(ReviewTableViewCell.self, forCellReuseIdentifier: ReviewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        reviewTable.delegate = self
        reviewTable.dataSource = self
        view.addSubview(reviewTable)
        fetchMovies(moviesID: movieID)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reviewTable.frame = view.bounds
    }
    
    func fetchMovies(moviesID: Int){
        
        APICaller.shared.getReviewsMovie(idMovie: moviesID) { [weak self] result in
            switch result {
            case .success(let success):
                self?.review = success
                DispatchQueue.main.async {
                    self?.reviewTable.reloadData()
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    

}


extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier, for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }
        
        let reviewUser = review[indexPath.row]

        cell.configure2(with: ReviewMoviesViewModel(name: reviewUser.author ?? "uknown", context: (reviewUser.content) ?? ""))
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

