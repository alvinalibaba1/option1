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
        
        reviewsButton.addTarget(self, action: #selector(buttonReviews), for: .touchUpInside)
        
        configureConstraint()
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
        
        let overviewLabelConstraint = [
        
            overviewLabel.topAnchor.constraint(equalTo: moviesTitleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        ]
        
        
        let reviewsButtonConstraint = [
        
            reviewsButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 20),
            reviewsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            reviewsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        ]
        
    
        NSLayoutConstraint.activate(webViewContraint)
        NSLayoutConstraint.activate(moviesTitleLabelConstraint)
        NSLayoutConstraint.activate(overviewLabelConstraint)
        NSLayoutConstraint.activate(reviewsButtonConstraint)
    }
    
    
    public func configure(with viewModel: DetailMovieViewModel) {
        moviesTitleLabel.text = viewModel.movie.original_title
        overviewLabel.text = viewModel.movie.overview
        
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(viewModel.youtubeView.id.videoId ?? "")") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
}
