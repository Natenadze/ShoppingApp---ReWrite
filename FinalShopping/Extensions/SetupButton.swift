//
//  SetupButton.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 10.05.23.
//

import UIKit

extension UIButton {
    
    func setup(withTitle name: String) {
        
        backgroundColor = .buttonCustomColor
        self.setTitle(name, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 6
    }
}
