//
//  CoreProductModel+CoreDataProperties.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 12.05.23.
//
//

import Foundation
import CoreData
 

extension CoreProductModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreProductModel> {
        return NSFetchRequest<CoreProductModel>(entityName: "CoreProductModel")
    }

    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension CoreProductModel {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: CoreProduct)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: CoreProduct)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}

extension CoreProductModel : Identifiable {

}
