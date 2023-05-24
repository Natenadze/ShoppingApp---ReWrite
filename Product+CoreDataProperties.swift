//
//  Product+CoreDataProperties.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 24.05.23.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var brand: String?
    @NSManaged public var category: String?
    @NSManaged public var price: Int64
    @NSManaged public var stock: Int64
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?
    @NSManaged public var choosenQuantity: Int64
    @NSManaged public var parentModel: ProductModel?

}

extension Product : Identifiable {

}
