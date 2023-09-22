//
//  FilterGenreTableViewCell.swift
//  Option1
//
//  Created by temp on 21/09/23.
//

import UIKit

class FilterGenreTableViewCell: UITableViewCell {
    
    static let identifier = "FilterGenreTableViewCell"
    
    public let genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(genresLabel)
        
        
//        applyContraints()
    }
    
    
//    private func applyContraints() {
//        let genresLabelContraint = [
//
//        ]
//    }
//
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
