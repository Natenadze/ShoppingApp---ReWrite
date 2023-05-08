//
//  SummaryView.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 08.05.23.
//

import UIKit

class SummaryView: UIView {
    
    // MARK: - Properties
    
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


// MARK: - Style & Layout

extension SummaryView {
    
    func style() {
        backgroundColor = .lightGray
    }
    
    func layout() {
        
    }
}
