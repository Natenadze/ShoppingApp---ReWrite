//
//  ShoppingVM.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 10.05.23.
//

import UIKit


class ShoppingVM {
    
    
    
    func fetchData(withUrl url: String, completion: @escaping ([[Product]]) -> Void) {
        
        var sectionitems = [[Product]]()
        
        NetworkManager.performURLRequest(url) { (data: ProductModel)  in
            
            let itemsDict = Dictionary(grouping: data.products, by: {$0.category})
            
            for (_, item) in itemsDict.sorted(by: { $0.key < $1.key }) {
                sectionitems.append(item)
            }
            
            DispatchQueue.main.async {
                completion(sectionitems)
            }
            
        }
    }
    
    
}
