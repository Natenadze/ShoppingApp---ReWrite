//
//  NetworkManager.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 09.05.23.
//

import Foundation
import CoreData

// from my old project
struct NetworkManager {
    
    static func performURLRequest<T:Decodable>(_ url: String, context: NSManagedObjectContext, completion: @escaping (T)-> Void) {
        
        guard let url = URL(string: url) else {
            print("no url")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
            }
            
//            if let httpResponse = response as? HTTPURLResponse {
//                let status = httpResponse.statusCode
//            }
            
            guard let data else {
                print("no data")
                return
                
            }
            
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
            
            let result = try? decoder.decode(T.self, from: data)
            guard let result else {
                print("no result")
                return
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
            
        }.resume()
    }
}
