//
//  NetworkManager.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 26.08.2022.
//

import UIKit

class NetworkManager {
    
    //MARK: - Propeties
    static let shared = NetworkManager()
    static let usersPerPage = 60
    private let baseUrl = "https://api.github.com/"
    let cache = NSCache<NSString, UIImage>()
    
    //MARK: - Inits
    private init() {}
    
    //MARK: - Get methods
    func getFollowers(for username: String, page: Int, completed: @escaping(Result<[Follower], GHFError>) -> Void) {
        let endpointUrl = baseUrl + "users/\(username)/followers?per_page=\(NetworkManager.usersPerPage)&page=\(page)"
        
        guard let url = URL(string: endpointUrl) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponce))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch  {
                completed(.failure(.invalidData))
            }

        }
        
        task.resume()
    }
    
    func getUserInfo(for username: String, completed: @escaping(Result<User, GHFError>) -> Void) {
        let endpointUrl = baseUrl + "users/\(username)"
        
        guard let url = URL(string: endpointUrl) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponce))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch  {
                completed(.failure(.invalidData))
            }

        }
        
        task.resume()
    }
    
    //Download avatar image
    func downloadAvatarImage(from url: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: url)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: url) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, responce, error in
            
            guard let self = self,
                  error == nil,
                  let responce = responce as? HTTPURLResponse, responce.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
