//
//  DetailMoviesViewController.swift
//  Option1
//
//  Created by temp on 21/09/23.
//

import Foundation
import WebKit

class DetailMovieViewController: UIViewController {
    
    var viewModel: DetailMovieViewModel

    var genresFilm: [GenresFilm] = [GenresFilm]()
    
    init(viewModel: DetailMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let reviewsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reviews", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Release date:"
        return label
    }()
    
    private let releaseLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Genre: "
        return label
    }()
    
    private var genreLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moviesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .lightGray
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.text = "This is the best movies i ever watch"
        return label
    }()
    
    
    
    private let webView: WKWebView =  {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = .systemBackground
        return webView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemBackground
        
        
        view.addSubview(webView)
        view.addSubview(moviesTitleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(reviewsButton)
        view.addSubview(releaseLabel)
        view.addSubview(releaseLabel2)
        view.addSubview(genreLabel)
        view.addSubview(genreLabel2)
        
        reviewsButton.addTarget(self, action: #selector(buttonReviews), for: .touchUpInside)
        
        configureConstraint()
        
        fetchGenre()
    }
    
    
    @objc func buttonReviews(_ sender: UIButton)  {
        DispatchQueue.main.async {
            let vc = ReviewViewController(movieID: (self.viewModel.movie.id))
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    
    
    func configureConstraint() {
        let webViewContraint = [
        
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250)
            
        ]
        
        let moviesTitleLabelConstraint = [
        
            moviesTitleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            moviesTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20)
            
            
        ]
        
        let releaseLabelConstraint = [
        
            releaseLabel.topAnchor.constraint(equalTo: moviesTitleLabel.bottomAnchor, constant: 20),
            releaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            releaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ]
        
        
        let releaseLabelConstraint2 = [
        
            releaseLabel2.topAnchor.constraint(equalTo: moviesTitleLabel.bottomAnchor, constant: 20),
            releaseLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130),
            releaseLabel2.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ]
        
        let genreLabelConstraint = [
        
            genreLabel.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant: 20),
            genreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            genreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ]
        
        let genreLabelConstraint2 = [
        
            genreLabel2.topAnchor.constraint(equalTo: releaseLabel2.bottomAnchor, constant: 20),
            genreLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130),
            genreLabel2.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ]
        
        
        
        let overviewLabelConstraint = [
        
            overviewLabel.topAnchor.constraint(equalTo: moviesTitleLabel.bottomAnchor, constant: 150),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        ]
        
        
        let reviewsButtonConstraint = [
        
            reviewsButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            reviewsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            reviewsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -180),
        
        ]
        
    
        NSLayoutConstraint.activate(webViewContraint)
        NSLayoutConstraint.activate(moviesTitleLabelConstraint)
        NSLayoutConstraint.activate(overviewLabelConstraint)
        NSLayoutConstraint.activate(reviewsButtonConstraint)
        NSLayoutConstraint.activate(releaseLabelConstraint)
        NSLayoutConstraint.activate(releaseLabelConstraint2)
        NSLayoutConstraint.activate(genreLabelConstraint)
        NSLayoutConstraint.activate(genreLabelConstraint2)
        
    }
    
    
    func fetchGenre() {
        
        APICaller.shared.getGenresMovie2(idMovie: viewModel.movie.id) { result in
            switch result {
            case .success(let success):
                self.genresFilm = success
                self.genreLabel2.text = self.viewModel.genres.name
                print(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    

    
    public func configure(with viewModel: DetailMovieViewModel) {
        moviesTitleLabel.text = viewModel.movie.original_title
        overviewLabel.text = viewModel.movie.overview
        releaseLabel2.text = viewModel.movie.release_date
        genreLabel2.text = viewModel.genres.name

        
        guard let url = URL(string: "https://www.youtube.com/embed/\(viewModel.youtubeView.id.videoId ?? "")") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
}
