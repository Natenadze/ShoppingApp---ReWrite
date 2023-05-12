//
//  ShoppingVM.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 10.05.23.
//

import UIKit

protocol ShoppingVMDelegate: AnyObject {
    
    func updateView()
}


class ShoppingVM {
    
    // MARK: - Model
    
    var sectionitems: [[Product]]? {
        didSet {
            delegate?.updateView()
        }
    }
    
    weak var delegate: ShoppingVMDelegate?
    
    // MARK: - Properties
    
    func sectionitems(section: Int) -> String {
        sectionitems?[section][0].category.uppercased() ?? ""
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        sectionitems?[section].count ?? 0
    }
     
    var getNumberOfSections: Int {
        sectionitems?.count ?? 0
    }
    
    
    
    

    // MARK: - Networking
    
    func fetchData(withUrl url: String) {
        
        var items = [[Product]]()
        
        NetworkManager.performURLRequest(url) { (data: ProductModel)  in
            
            let itemsDict = Dictionary(grouping: data.products, by: {$0.category})
            
            for (_, item) in itemsDict.sorted(by: { $0.key < $1.key }) {
                items.append(item)
            }
            
            self.sectionitems = items
            
        }
    }
    
    
}
