//
//  NetworkManager.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 26.08.2022.
//

import Foundation

class NetworkManager {
    
    //MARK: - Propeties
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/"
    let usersPerPage = 60
    
    //MARK: - Inits
    private init() {}
    
    //MARK: - Get methods
    func getFollowers(for username: String, page: Int, completed: @escaping(Result<[Follower], GHFError>) -> Void) {
        let endpointUrl = baseUrl + "users/\(username)/followers?per_page=\(usersPerPage)&page=\(page)"
        
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
}
