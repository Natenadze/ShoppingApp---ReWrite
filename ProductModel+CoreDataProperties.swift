//
//  ProductModel+CoreDataProperties.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 23.05.23.
//
//

import Foundation
import CoreData


extension ProductModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductModel> {
        return NSFetchRequest<ProductModel>(entityName: "ProductModel")
    }

    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension ProductModel {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension ProductModel : Identifiable {

}
