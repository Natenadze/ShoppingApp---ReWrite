//
//  SummaryView.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 08.05.23.
//

import UIKit

class SummaryView: UIView {
    
    // MARK: - Properties
    private let parentRightStack = UIStackView()
    private let leftStack = UIStackView()
    private let rightStack1 = UIStackView()
    private let rightStack2 = UIStackView()
    private let subTotal = UILabel()
    private let vat = UILabel()
    private let delivery = UILabel()
    private let total = UILabel()
    
    let subTotalTextLbl = UILabel()
    let vatTextLbl = UILabel()
    let deliveryTextLbl = UILabel()
    let TotalTextLbl = UILabel()
    
    private let dollarSign = UILabel()
    private let dollarSign2 = UILabel()
    private let dollarSign3 = UILabel()
    private let dollarSign4 = UILabel()
    
    
    
    
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray4
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
        parentRightStack.translatesAutoresizingMaskIntoConstraints = false
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        rightStack1.translatesAutoresizingMaskIntoConstraints = false
        subTotal.translatesAutoresizingMaskIntoConstraints = false
        subTotalTextLbl.translatesAutoresizingMaskIntoConstraints = false
        vat.translatesAutoresizingMaskIntoConstraints = false
        vatTextLbl.translatesAutoresizingMaskIntoConstraints = false
        delivery.translatesAutoresizingMaskIntoConstraints = false
        deliveryTextLbl.translatesAutoresizingMaskIntoConstraints = false
        total.translatesAutoresizingMaskIntoConstraints = false
        TotalTextLbl.translatesAutoresizingMaskIntoConstraints = false
        dollarSign.translatesAutoresizingMaskIntoConstraints = false
        
        
        parentRightStack.distribution = .fillProportionally
        
        leftStack.axis = .vertical
        leftStack.spacing = 8
        leftStack.distribution = .equalSpacing
        
        rightStack1.axis = .vertical
        rightStack1.spacing = 8
        rightStack1.distribution = .equalSpacing
        rightStack1.alignment = .trailing
        
        rightStack2.axis = .vertical
        rightStack2.spacing = 8
        rightStack2.distribution = .equalSpacing
        
        //
        subTotal.text = "subTotal:"
        subTotal.font = UIFont.boldSystemFont(ofSize: 18)
        
        vat.text = "vat:"
        vat.font = UIFont.boldSystemFont(ofSize: 18)
        
        delivery.text = "delivery:"
        delivery.font = UIFont.boldSystemFont(ofSize: 18)
        
        total.text = "TOTAL:"
        total.font = UIFont.boldSystemFont(ofSize: 22)
        
        dollarSign.text = "$"
        dollarSign.font = UIFont.boldSystemFont(ofSize: 18)
        
        dollarSign2.text = "$"
        dollarSign2.font = UIFont.boldSystemFont(ofSize: 18)
        
        dollarSign3.text = "$"
        dollarSign3.font = UIFont.boldSystemFont(ofSize: 18)
        
        dollarSign4.text = "$"
        dollarSign4.font = UIFont.boldSystemFont(ofSize: 22)
        
        //
        subTotalTextLbl.font = UIFont.boldSystemFont(ofSize: 18)
        vatTextLbl.font = UIFont.boldSystemFont(ofSize: 18)
        deliveryTextLbl.font = UIFont.boldSystemFont(ofSize: 18)
        TotalTextLbl.font = UIFont.boldSystemFont(ofSize: 22)
        
        //
        subTotalTextLbl.text = "0"
        vatTextLbl.text = "0"
        deliveryTextLbl.text = "0"
        TotalTextLbl.text = "0"
        
        
        
    }
    
    func layout() {
        leftStack.addArrangedSubview(subTotal)
        leftStack.addArrangedSubview(vat)
        leftStack.addArrangedSubview(delivery)
        leftStack.addArrangedSubview(total)
        rightStack1.addArrangedSubview(subTotalTextLbl)
        rightStack1.addArrangedSubview(vatTextLbl)
        rightStack1.addArrangedSubview(deliveryTextLbl)
        rightStack1.addArrangedSubview(TotalTextLbl)
        
        rightStack2.addArrangedSubview(dollarSign)
        rightStack2.addArrangedSubview(dollarSign2)
        rightStack2.addArrangedSubview(dollarSign3)
        rightStack2.addArrangedSubview(dollarSign4)
        parentRightStack.addArrangedSubview(rightStack1)
        parentRightStack.addArrangedSubview(rightStack2)
        
        addSubview(leftStack)
        addSubview(parentRightStack)
        
        NSLayoutConstraint.activate([
            
            rightStack2.widthAnchor.constraint(equalToConstant: 14),
            
            leftStack.widthAnchor.constraint(equalToConstant: 150),
            leftStack.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            leftStack.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: leftStack.bottomAnchor, multiplier: 7),
            
            parentRightStack.topAnchor.constraint(equalTo: leftStack.topAnchor),
            parentRightStack.leadingAnchor.constraint(equalTo: leftStack.trailingAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: parentRightStack.trailingAnchor, multiplier: 1),
            parentRightStack.bottomAnchor.constraint(equalTo: leftStack.bottomAnchor)
            
        ])
        
    }
}
