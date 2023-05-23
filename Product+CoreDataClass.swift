//
//  Product+CoreDataClass.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 23.05.23.
//
//

import Foundation
import CoreData


enum DecoderConfigurationError: Error {
    case missingManagedObjectContext
}

public class Product: NSManagedObject, Decodable {
    
    var choosenQuantity = 0

    enum CodingKeys: CodingKey {
        case brand, category, price, stock, title, thumbnail
    }
    
    
    required convenience public init(from decoder: Decoder) throws {
        
        guard let context = decoder.userInfo[.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        
        self.init(context: context)
        
        let container  = try decoder.container(keyedBy: CodingKeys.self)
        self.brand     = try container.decode(String.self, forKey: .brand)
        self.category  = try container.decode(String.self, forKey: .category)
        self.price     = try container.decode(Int64.self,  forKey: .price)
        self.stock     = try container.decode(Int64.self,  forKey: .stock)
        self.title     = try container.decode(String.self, forKey: .title)
        self.title     = try container.decode(String.self, forKey: .title)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        
    }
    
}


extension CodingUserInfoKey {
    
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
