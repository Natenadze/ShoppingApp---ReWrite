//
//  NetworkManager.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 09.05.23.
//

import Foundation

// from my old project
struct NetworkManager {
    
    static func performURLRequest<T:Codable>(_ url: String, completion: @escaping (T)-> Void) {
        
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let status = httpResponse.statusCode
                print(status)
             
            }
            
            guard let data else {return}
            let result = try? JSONDecoder().decode(T.self, from: data)
            guard let result else {return}
            
            DispatchQueue.main.async {
                completion(result)
            }
            
        }.resume()
    }
}
