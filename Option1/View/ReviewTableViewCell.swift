//
//  ReviewTableViewCell.swift
//  Option1
//
//  Created by temp on 26/09/23.
//

import UIKit

protocol ReviewsTableViewCellDelegate: AnyObject {
    func  reviesTableViewCellDidtap(_ cell: ReviewTableViewCell, viewModel: ReviewMoviesViewModel)
}

class ReviewTableViewCell: UITableViewCell {
    
    static let identifier = "ReviewTableViewCell"
    
    weak var delegate2: ReviewsTableViewCellDelegate?
    
    private let labelNameReview: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let labelReviewContent: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(labelNameReview)
        contentView.addSubview(labelReviewContent)
        
        applyConstraints()
    }
    
    
    
    func applyConstraints() {
        
        let labelNameConstraint = [
        
            labelNameReview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelNameReview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            labelNameReview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            labelNameReview.widthAnchor.constraint(equalToConstant: 100)
            
        ]
        
        let labelContentConstraint = [
        
            labelReviewContent.leadingAnchor.constraint(equalTo: labelNameReview.trailingAnchor),
            labelReviewContent.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ]
        
        
        NSLayoutConstraint.activate(labelNameConstraint)
        NSLayoutConstraint.activate(labelContentConstraint)
        
    }
    
    public func configure2(with model: ReviewMoviesViewModel) {
        labelNameReview.text = model.name
        labelReviewContent.text = model.context
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
