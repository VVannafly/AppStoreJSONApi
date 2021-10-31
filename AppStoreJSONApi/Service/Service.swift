//
//  Service.swift
//  AppStoreJSONApi
//
//  Created by Dmitriy Chernov on 09.02.2021.
//

import Foundation

class Service {
    
    static let shared = Service()
    func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString =  "https://rss.applemarketingtools.com/api/v2/ru/apps/top-free/50/apps.json"
        
        fetchAppGroup(urlString: urlString, completion: completion)

    }
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        fetchAppGroup(urlString: "https://rss.applemarketingtools.com/api/v2/ru/apps/top-paid/10/apps.json", completion: completion)
    }
    
    // helper
    
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping ([SocialApp]? , Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    //declare my generic json function here
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else { return }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
    
}
