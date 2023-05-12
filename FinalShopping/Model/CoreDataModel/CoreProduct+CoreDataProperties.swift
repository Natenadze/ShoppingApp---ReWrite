//
//  CoreProduct+CoreDataProperties.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 12.05.23.
//
//

import Foundation
import CoreData


extension CoreProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreProduct> {
        return NSFetchRequest<CoreProduct>(entityName: "CoreProduct")
    }

    @NSManaged public var title: String?
    @NSManaged public var price: Int64
    @NSManaged public var stock: Int64
    @NSManaged public var brand: String?
    @NSManaged public var category: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var choosenQuantity: Int64
    @NSManaged public var parentModel: CoreProductModel?

}

extension CoreProduct : Identifiable {

}
