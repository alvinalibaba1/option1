//
//  ReviewViewController.swift
//  Option1
//
//  Created by temp on 26/09/23.
//

import UIKit

class ReviewViewController: UIViewController {
    
    var fantasy: [Data] = [Data]()
        
    var review: [ReviewsMovie] = [ReviewsMovie]()
    
    weak var delegate2: CollectionViewTableViewCellDelegate?
    
    
    
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
        fetchMovies()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reviewTable.frame = view.bounds
    }
    
    func fetchMovies(id: idMovies = .id){
        
        APICaller.shared.getReviewMovie(idMovies: id.rawValue) { [weak self] result in
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



//extension ReviewViewController: ReviewsTableViewCellDelegate {
//    func reviesTableViewCellDidtap(_ cell: ReviewTableViewCell, viewModel: ReviewMoviesViewModel) {
//        DispatchQueue.main.async { [weak self] in
////            let vc = 
//        }
//    }
//}
