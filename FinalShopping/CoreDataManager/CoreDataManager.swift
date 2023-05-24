//
//  CoreDataManager.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 23.05.23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - Singleton
    static let shared = CoreDataManager()
    
    
    // MARK: - Properties
    
    let persistentContainer: NSPersistentContainer = {
        
        let conteiner = NSPersistentContainer(name: "FinalShopping")
        conteiner.loadPersistentStores { description, error in
            if let error {
                print(error.localizedDescription)
            }
        }
        
        return conteiner
    }()
    
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    // MARK: - Methods
    
//    // create busket item
//    func createBusketItem(image: Data, quantity: Int64, title: String, subTotal: String) -> Busket {
//        let item = Busket(context: viewContext)
//        item.image = image
//        item.quantity = quantity
//        item.title = title
//        item.subTotal = subTotal
//
//        return item
//    }
    
    // SAVE
    
    func save() {
        
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
    
    // Fetch
    
    func fetchBusket() -> [Busket] {
        let request: NSFetchRequest<Busket> = Busket.fetchRequest()
        
        var items = [Busket]()
        
        do {
            items =  try viewContext.fetch(request)
        } catch {
            print("couldnt fetch Busket from core data manager")
        }
        
        return items
    }
       
    func fetchProduct() throws -> [Product] {
        let request: NSFetchRequest<Product> = Product.fetchRequest()
        
        var items = [Product]()
        
        do {
            items =  try viewContext.fetch(request)
        } catch {
            print("couldnt fetch Product from core data manager")
        }
        
        return items
    }
    
    // DELETE
    
    func deleteBusketItem(_ item: Busket) {
        viewContext.delete(item)
        save()
    }
    
    
}
