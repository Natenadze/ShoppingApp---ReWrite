//
//  SummaryVM.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 12.05.23.
//

import UIKit



struct SummaryVM {
    
    
    var basketModel: [Basket]
    
    
    
    var subTotal: Int {
        var sum = 0
        
        basketModel.forEach({ model in
            let q = model.quantity
            sum += Int(model.subTotal ?? "0")! * Int(q)
        })
        
        return sum
    }
    
    var vat: Double {
        let vatValue = Double(subTotal) * 0.21
        let formattedVat = String(format: "%.2f", vatValue)
        return Double(formattedVat)!
    }
    
    
    var delivery: Double {
        if subTotal == 0 || subTotal >= 100 {
            return 0
        }
        
        return 9
    }
    
    var Total: Double {
        let sum = Double(subTotal) + vat + delivery
        let formattedSum = String(format: "%.2f", sum)
        return Double(formattedSum)!
    }
    
    var success: Bool {
        if Total < 200 {
            return true
        }
        return false
    }
    
    //
    
    
    var resultLogo: UIImage {
        let declineLogo = UIImage(named: "decline")!
        let confirmLogo = UIImage(named: "confirm")!
        
        if Total < 200 {
            return confirmLogo
        }
        return declineLogo
    }
    
    var resultMessage: String {
        
        if Total < 200 {
            return "Success"
        }
        return "Payment Failure"
    }
    
    
    
}
