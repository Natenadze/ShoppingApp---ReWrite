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
            setupObserver()
        }
    }
    
    var busket = [BusketModel]()
    
  
    
    // MARK: - Properties
    
    weak var delegate: ShoppingVMDelegate?
    
    func sectionitems(section: Int) -> String {
        sectionitems?[section][0].category.uppercased() ?? ""
    }
    
    func getNumberOfRowsInSection(section: Int) -> Int {
        sectionitems?[section].count ?? 0
    }
     
    var getNumberOfSections: Int {
        sectionitems?.count ?? 0
    }
    
    // bottom View info
    
    var totalQuantity: String {
            var q = 0
            busket.forEach { q += $0.quantity }
        
            return String(q)
    }
     
    var totalPrice: String {
        var p = 0
        busket.forEach { p += (Int($0.subTotal)! * $0.quantity) }
        
        return String(p)
    }
    
    
    
    // MARK: - LifeCycle
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("removed notif observer")
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
    
    // MARK: - Setup Notification Center observer
    
    func setupObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePlusNotif(_:)), name: .plusNotif, object: nil)
         
        NotificationCenter.default.addObserver(self, selector: #selector(handleMinusNotif(_:)), name: .minusNotif, object: nil)
        
    }
    
    @objc func handlePlusNotif(_ sender: Notification) {
        let item = sender.userInfo!["item"] as! BusketModel
        
        var foundItem = false
        
        for (index, busketItem) in busket.enumerated() {
            if busketItem.title == item.title {
                busket[index].quantity += 1
                foundItem = true
                break
            }
        }
        
        if !foundItem {
            busket.append(item)
        }
        
        
    }
    
    @objc func handleMinusNotif(_ sender: Notification) {
        let item = sender.userInfo!["item"] as! BusketModel
        
        for (index, busketItem) in busket.enumerated() {
            if busketItem.title == item.title {
                if busket[index].quantity == 1 {
                    busket.remove(at: index)
                    break
                }
                busket[index].quantity -= 1
            }
        }
    }
    
    func updateMainBase() {
        busket.forEach { item in
            // Find the corresponding product in sectionitems
            if let product = sectionitems?.flatMap({ $0 }).first(where: { $0.title == item.title }) {
                // Subtract the quantity from the stock
                product.stock -= item.quantity
                product.choosenQuantity = 0
            }
        }
    }
    
   
}
