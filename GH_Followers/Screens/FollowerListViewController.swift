//
//  FollowerViewController.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 26.08.2022.
//

import UIKit

class FollowerListViewController: GHFDataLoadingViewController {
    
    //MARK: - Enum
    enum Section { case main }
    
    //MARK: - Properties
    var username: String!
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    var isLoadingMoreFollowers = false
    
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    
    var followerCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    //MARK: - Inits
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addbuttonTap))
        navigationItem.rightBarButtonItem = addButton
    }
    
    //Configure search controller
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Кого ищем?"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    //Get followers 
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
                
            case.failure(let error):
                self.presentAlertOnMainThread(title: "Что-то пошло не так.😱", message: error.rawValue, buttonTitle: "Понятно")
            }
            
            self.isLoadingMoreFollowers = false
        }
    }
    
    //Update UI elements in follover list
    private func updateUI(with followers: [Follower]) {
        if followers.count < NetworkManager.usersPerPage { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if followers .isEmpty {
            let message = "У пользователя пока нет подписчиков.😒 Стань первым!😏"
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
            return
        }
        
        self.updateData(on: self.followers)
    }
    
    //Add user to favorite list
    private func addUserToFavorite(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistanceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.presentAlertOnMainThread(title: "Готово!🫡", message: "Пользователь успешно добавлен в избранное.🥳", buttonTitle: "Отлично!")
                return
            }
            self.presentAlertOnMainThread(title: "Что-то пошло не так.😱", message: error.rawValue, buttonTitle: "Понятно")
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
    
    //MARK: - Objc methods
    //Add button tapped
    @objc func addbuttonTap() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavorite(user: user)
            
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Что-то пошло не так.😱", message: error.rawValue, buttonTitle: "Понятно")
            }
        }
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
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
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
extension FollowerListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: followers)
            isSearching = false
            return
        }
        
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
}

//Delegate for request follower list
extension FollowerListViewController: UserInfoViewControllerDelegate {
    func didRequestFollowers(with username: String) {
        self.username = username
        title = username
        page = 1
        
        followers.removeAll()
        filteredFollowers.removeAll()
        followerCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
