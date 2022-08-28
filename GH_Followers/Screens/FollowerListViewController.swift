//
//  FollowerViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 26.08.2022.
//

import UIKit

//MARK: - Protocols
protocol FollowerListViewControllerDelegate: class {
    func didRequestFollowers(with username: String)
}

class FollowerListViewController: UIViewController {
    
    //MARK: - Enum
    enum Section { case main }
    
    //MARK: - Properties
    var username: String!
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    
    var followerCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configure()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - Methods
    //Configure view
    private func configure() {
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    //Configure search controller
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Кого ищем?"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    //Get followers 
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < NetworkManager.usersPerPage { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if followers .isEmpty {
                    let message = "У пользователя пока нет подписчиков.😒 Стань первым!😏"
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                
                self.updateData(on: self.followers)
                
            case.failure(let error):
                self.presentAlertOnMainThread(title: "Что-то пошло не так.😱", message: error.rawValue, buttonTitle: "Понятно")
            }
        }
    }
    
    //Configure & update data source
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: followerCollectionView, cellProvider: { (followerCollectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = followerCollectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifier, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    //Configure collection view
    private func configureCollectionView() {
        followerCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createFlowLayout(in: view))
        view.addSubview(followerCollectionView)
        followerCollectionView.delegate = self
        followerCollectionView.backgroundColor = .systemBackground
        followerCollectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
    }
}

//MARK: - Extensoins
//Collection view Delegate
extension FollowerListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeFollowersArray = isSearching ? filteredFollowers : followers
        let follower = activeFollowersArray[indexPath.item]
        
        let userInfoViewController = UserInfoViewController()
        userInfoViewController.username = follower.login
        userInfoViewController.delegate = self
        let userInfoNavigationController = UINavigationController(rootViewController: userInfoViewController)
        present(userInfoNavigationController, animated: true)
    }
}

//Search controller result updater
extension FollowerListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

//Delegate for request follower list
extension FollowerListViewController: FollowerListViewControllerDelegate {
    func didRequestFollowers(with username: String) {
        self.username = username
        title = username
        page = 1
        
        followers.removeAll()
        filteredFollowers.removeAll()
        followerCollectionView.setContentOffset(.init(x: 0, y: -185), animated: true)
        getFollowers(username: username, page: page)
    }
}
