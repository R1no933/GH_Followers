//
//  GHFTabBarController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 31.08.2022.
//

import UIKit

class GHFTabBarController: UITabBarController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNavigationController(), createFavoritesNavigationController()]
    }
    
    //MARK: - Methods
    //Create search nav controller
    func createSearchNavigationController() -> UINavigationController {
        let searchViewController = SearchViewController()
        searchViewController.title = "Поиск"
        searchViewController.tabBarItem = UITabBarItem(
            title: "Поиск",
            image: SFSymbols.search,
            tag: 0)
        
        return UINavigationController(rootViewController: searchViewController)
    }
    
    //Create favorite nav controller
    func createFavoritesNavigationController() -> UINavigationController {
        let favoritesViewController = FavoritesListViewController()
        favoritesViewController.title = "Избранное"
        favoritesViewController.tabBarItem = UITabBarItem(
            title: "Избранное",
            image: SFSymbols.favoriteTabBar,
            tag: 1)
        
        return UINavigationController(rootViewController: favoritesViewController)
    }
}
