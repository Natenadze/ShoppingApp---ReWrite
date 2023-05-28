//
//  MockModel.swift
//  FinalShoppingUnitTests
//
//  Created by Davit Natenadze on 28.05.23.
//

import Foundation
@testable import FinalShopping



class MockSummaryVM {
    
    static var shared = MockSummaryVM()
    
    let context = CoreDataManager.shared.viewContext
    
    
    var basketModel: [Basket] {
        
        get { return createBasketModel() }
    }
    
    
    func createBasketModel() -> [Basket] {
        
        let item1 = Basket(context: context)
        item1.image = nil
        item1.quantity = 1
        item1.subTotal = "10"
        item1.title = "Apple"
         
        let item2 = Basket(context: context)
        item2.image = nil
        item2.quantity = 2
        item2.subTotal = "15"
        item2.title = "Apple"
         
        let item3 = Basket(context: context)
        item3.image = nil
        item3.quantity = 3
        item3.subTotal = "20"
        item3.title = "Apple"
        
        let model: [Basket] = [item1, item2, item3]
        
        return model
        
    }


      

    
    
}
