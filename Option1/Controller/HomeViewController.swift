//
//  HomeViewController.swift
//  Option1
//
//  Created by temp on 08/09/23.
//

import UIKit

enum Sections: Int {
    case Fantasy = 0
    case Action = 1
    case History = 2
    case Romance = 3
    case War = 4
    
}

class HomeViewController: UIViewController {
    
    let sectionTittle: [String] = ["Fantasy", "Action", "History", "Romance", "War"]

    
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
        APICaller.shared.getFilterGenreMovie(with: "28" ) { result in
            //
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    

    
}


extension HomeViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTittle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.Fantasy.rawValue:
            
            APICaller.shared.getGenreMovies { result in
                switch result {
                case .success(let genres):
                    cell.configure(with: genres)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
        case Sections.Action.rawValue:
            APICaller.shared.getActionMovies{ result in
                switch result {
                case .success(let actionMovies):
                    cell.configure(with: actionMovies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            
        case Sections.History.rawValue:
            APICaller.shared.getThrillerMovie{ result in
                switch result {
                case .success(let genres):
                    cell.configure(with: genres)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Romance.rawValue:
            APICaller.shared.getRomanceMovie{ result in
                switch result {
                case .success(let genres):
                    cell.configure(with: genres)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.War.rawValue:
            APICaller.shared.getWarMovie{ result in
                switch result {
                case .success(let genres):
                    cell.configure(with: genres)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTittle[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    
}


extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: DetailMovieViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = DetailMovieViewController(viewModel: viewModel)
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
