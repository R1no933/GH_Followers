//
//  PersistanceManager.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 29.08.2022.
//

import Foundation

enum PresistanceActionType {
    case add, remove
}

enum PersistanceManager {
    //MARK: - Properties
    static private let defaults = UserDefaults.standard
    
    //Keys
    enum Keys {
        static let favorites = "favorites"
    }
    
    //MARK: - Methods
    //Updated favorite list
    static func updateWith(favorite: Follower, actionType: PresistanceActionType, completed: @escaping (GHFError?) -> Void) {
        retriveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrivedFavorites = favorites
                
                switch actionType {
                case .add:
                    guard !retrivedFavorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrivedFavorites.append(favorite)
                case .remove:
                    retrivedFavorites.removeAll { $0.login == favorite.login }
                }
                
                completed(saveFavorite(favorites: retrivedFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    //Retrive favorites array
    static func retriveFavorites(completed: @escaping(Result<[Follower], GHFError>) -> Void) {
        guard let favroiteData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favroiteData)
            completed(.success(favorites))
        } catch  {
            completed(.failure(.unableToFavorite))
        }
    }
    
    //Encode and save favorite info
    static func saveFavorite(favorites: [Follower]) -> GHFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
