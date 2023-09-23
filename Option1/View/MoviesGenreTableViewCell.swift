//
//  MoviesGenreTableViewCell.swift
//  Option1
//
//  Created by temp on 19/09/23.
//

import UIKit
import SDWebImage

class MoviesGenreTableViewCell: UITableViewCell {

    static let identifier = "MoviesGenreTableViewCell"
    
    private let playTittleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let moviesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moviesPosterImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(moviesPosterImageView)
        contentView.addSubview(moviesLabel)
        contentView.addSubview(playTittleButton)
        
        applyConstraint()
        

    }
    
    
    private func applyConstraint() {
        let moviesPosterImageViewConstraint = [
        
            moviesPosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviesPosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            moviesPosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            moviesPosterImageView.widthAnchor.constraint(equalToConstant: 100)
            
        ]
        
        let moviesLabelConstraint = [
        
            moviesLabel.leadingAnchor.constraint(equalTo: moviesPosterImageView.trailingAnchor, constant: 20),
            moviesLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        
        ]
        
        let playTitleButtonConstraint = [
        
            playTittleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            playTittleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ]
        
        NSLayoutConstraint.activate(moviesLabelConstraint)
        NSLayoutConstraint.activate(moviesPosterImageViewConstraint)
        NSLayoutConstraint.activate(playTitleButtonConstraint)
    }
    
    
    public func configure(with model: MoviesGenreViewModel) {
        guard let url =  URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        moviesPosterImageView.sd_setImage(with: url, completed: nil)
        moviesLabel.text = model.moviesName
    }
    
    
    required init(coder: NSCoder) {
        fatalError()
    }
}
