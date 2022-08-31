//
//  GHFAvataImageView.swift
//  GH_Followers
//
//  Created by Dmitriy Baskakov on 27.08.2022.
//

import UIKit

class GHFAvataImageView: UIImageView {
    
    //MARK: - Properties
    let placeholderImage = UIImage(named: "avatar-placeholder")
    let cache = NetworkManager.shared.cache
    
    //MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    //Configure view
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //Download & caching avatar image
    #warning("Refactoring and replacing func in NetworkManager")
    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, responce, error in
            guard let self = self else { return }
            
            if error != nil { return }
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async { self.image = image }
        }
        
        task.resume()
    }
}
