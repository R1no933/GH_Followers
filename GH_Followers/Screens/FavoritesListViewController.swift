//
//  FavoritesListViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 26.08.2022.
//

import UIKit

class FavoritesListViewController: GHFDataLoadingViewController {
    
    //MARK: - Properties
    let tableView = UITableView()
    var favorites: [Follower] = []
    
    //MARK: - Inits
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    //MARK: - Methods
    //Get favorites
    private func getFavorites() {
        PersistanceManager.retriveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "У вас еще нет избранных пользователей. Пора это исправить!!!😉", in: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                self.favorites = favorites
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Что-то пошло не так.😱", message: error.rawValue, buttonTitle: "Понятно")
            }
        }
    }
    
    //Caonfigure view controller
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Избранное"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //Configure table view
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FollowerCell.identifier)
    }
}

//Extensions
//Delegate & data source for table view
extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowerCell.identifier) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    // Delegate for tap on user cell & show his followers
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let userFollowersViewController = FollowerListViewController(username: favorite.login)
        
        navigationController?.pushViewController(userFollowersViewController, animated: true)
    }
    
    //Swipe for delete fron favorites
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistanceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else { return }
            self.presentAlertOnMainThread(title: "Что-то пошло не так.😱", message: error.rawValue, buttonTitle: "Понятно ")
        }
    }
}
