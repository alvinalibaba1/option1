//
//  ViewController.swift
//  Option1
//
//  Created by temp on 07/09/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: GenreViewController())
        
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "book")
        
        vc1.title = "Home"
        vc2.title = "Genre"
        
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2], animated: true)
        
    }


}

