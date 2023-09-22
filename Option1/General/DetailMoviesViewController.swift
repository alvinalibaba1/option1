//
//  DetailMoviesViewController.swift
//  Option1
//
//  Created by temp on 21/09/23.
//

import Foundation
import WebKit

class DetailMovieViewController: UIViewController {
    
    
    private let moviesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry poter"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.text = "This is the best movies i ever watch"
        return label
    }()
    
    
    
    private let webView: WKWebView =  {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(webView)
        view.addSubview(moviesTitleLabel)
        view.addSubview(overviewLabel)
        
        
        configureConstraint()
    }
    
    
    func configureConstraint() {
        let webViewContraint = [
        
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
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
        
        NSLayoutConstraint.activate(webViewContraint)
        NSLayoutConstraint.activate(moviesTitleLabelConstraint)
        NSLayoutConstraint.activate(overviewLabelConstraint)
    }
    
    
    func configure(with model: DetailMovieViewModel) {
        moviesTitleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId ?? "")") else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
}
