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
    
    let context = CoreDataManager.shared.viewContext
    
    // MARK: - Model
    
    var sectionitems: [[Product]]? {
        didSet {
            delegate?.updateView()
            setupObserver()
            CoreDataManager.shared.save()
        }
    }
    
    var basket: [Basket]! {
        didSet {
            
        }
    }
    
    
    // MARK: - LifeCycle
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("removed notif observer")
    }
    
    
    // MARK: - Properties
    
    weak var delegate: ShoppingVMDelegate?
    
    // MARK: -
    
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
        basket?.forEach { q += Int($0.quantity) }
        return String(q)
    }
    
    var totalPrice: String {
        var p = 0
        basket?.forEach { p += (Int($0.subTotal ?? "0")! * Int($0.quantity)) }
        
        return String(p)
    }
    
    
    
    
    // MARK: - Networking
    
    func fetchData(withUrl url: String) {
        
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
                products.forEach { item in
                    item.choosenQuantity = 0
                }
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleBasketNotif), name: .notif, object: nil)
        
    }
    
    // MARK: - Selectors
    
    @objc func handleBasketNotif() {
        let item = CoreDataManager.shared.fetchBusket()
        
        self.basket = item
        
    }
    
    func updateMainBase() {
        basket?.forEach { item in
            // Find the corresponding product in sectionitems
            if let product = sectionitems?.flatMap({ $0 }).first(where: { $0.title == item.title }) {
                // Subtract the quantity from the stock
                product.stock -= Int64(item.quantity)
                product.choosenQuantity = 0
            }
        }
        try? context.save()
    }
    
    
}
