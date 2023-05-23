//
//  ShoppingVM.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 10.05.23.
//

import UIKit
import CoreData

protocol ShoppingVMDelegate: AnyObject {
    
    func updateView()
}


class ShoppingVM {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Model
    
    var sectionitems: [[Product]]? {
        didSet {
            delegate?.updateView()
            setupObserver()
            do {
                try context.save()
            }
            catch {
                print("couldnt save context (ShoppingVM)")
            }
            
        }
    }
    
    var busket = [BusketModel]()
    
  
    
    // MARK: - Properties
    
    weak var delegate: ShoppingVMDelegate?
    
    func sectionitems(section: Int) -> String {
        sectionitems?[section][0].category!.uppercased() ?? ""
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
        
//        var items = [[Product]]()
        
        // Check if data exists in CoreData
        guard let existingData = fetchExistingDataFromCoreData() else { return }
        
        if existingData.count != 0  {
              // Data exists in CoreData, update section items
              self.updateSectionItems(items: existingData)
              return
          }
        
        NetworkManager.performURLRequest(url, context: context) { (data: ProductModel)  in
            
            var items = [Product]()
            
            if let products = data.products?.allObjects as? [Product] {
                items = products
                self.updateSectionItems(items: items)
            } else {
                print("error updating sectionItems (ShoppingVM)")
            }
            
        }
    }
    
    func fetchExistingDataFromCoreData() -> [Product]? {
        // Fetch existing data from CoreData
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Error fetching existing data from CoreData: \(error)")
            return nil
        }
    }
    
    func updateSectionItems(items: [Product]) {
        
        var result = [[Product]]()
        
        let itemsDict = Dictionary(grouping: items, by: {$0.category})
        
        for (_, item) in itemsDict.sorted(by: { $0.key! < $1.key! }) {
            result.append(item)
        }
        self.sectionitems = result
    }
    
    // MARK: - Setup Notification Center observer
    
    func setupObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePlusNotif(_:)), name: .plusNotif, object: nil)
         
        NotificationCenter.default.addObserver(self, selector: #selector(handleMinusNotif(_:)), name: .minusNotif, object: nil)
        
    }
    
    // MARK: - Selectors
    
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
                product.stock -= Int64(item.quantity)
                product.choosenQuantity = 0
            }
        }
    }
    
   
}
