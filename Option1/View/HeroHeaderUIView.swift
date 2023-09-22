//
//  HeroHeaderUIView.swift
//  Option1
//
//  Created by temp on 08/09/23.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    
    private let playButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let heroimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "poster")
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func applyContraints() {
        
//        let playButtonConstraint = [
//        
//            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 90),
//            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
//            playButton.widthAnchor.constraint(equalToConstant: 100)
//            
//            
//        ]
//        
//        NSLayoutConstraint.activate(playButtonConstraint)
//        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroimageView)
        addGradient()
//        addSubview(playButton)
        applyContraints()
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroimageView.frame = bounds
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
