//
//  ProductModel+CoreDataClass.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 23.05.23.
//
//

import Foundation
import CoreData


public class ProductModel: NSManagedObject, Decodable {

    enum CodingKeys: CodingKey {
        case products
    }
    
    required convenience public init(from decoder: Decoder) throws {

        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.products = try container.decode(Set<Product>.self, forKey: .products) as NSSet

    }
    
}
