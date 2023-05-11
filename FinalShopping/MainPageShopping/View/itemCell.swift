//
//  itemCell.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 09.05.23.
//

import UIKit

protocol CustomTableViewCellDelegate: AnyObject {
    
    func reloadData(forCell cell: UITableViewCell)
}


class itemCell: UITableViewCell {
    
    // MARK: - Create Cell Identifier
    static var identifier: String {
        return String(describing: self)
    }

    // MARK: - Properties
    
    let itemImage = UIImageView()
    let itemLbl = UILabel()
    let itemRemainingLbl = UILabel()
    let xSign = UILabel()
    let priceLbl = UILabel()
    let dolarSign = UILabel()
    let choosenQuantityLbl = UILabel()
    let plusBtn = UIButton(type: .system)
    let minusBtn = UIButton(type: .system)
    
    var cellData: Product! {
        didSet {
            setupCell()
        }
    }
    
    weak var delegate: CustomTableViewCellDelegate?

    
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        style1()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    // MARK: - Helper
    
    func setupCell() {
        itemImage.image = UIImage(named: "aaa")
        choosenQuantityLbl.text = String(cellData.choosenQuantity ?? 0)
        itemLbl.text = cellData.title
        priceLbl.text = String(cellData.price)
        itemRemainingLbl.text = String(cellData.stock)
    }
    
    // MARK: - Selectors
    
    @objc func plusBtnTapped() {
        cellData.choosenQuantity = 1
        print(itemLbl.text ?? "empty")
        delegate?.reloadData(forCell: self)
    }

    @objc func minusBtnTapped() {
        print(itemRemainingLbl.text ?? "empty")
    }

}


// MARK: - Style & Layout

extension itemCell {
    
    func style1() {
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemLbl.translatesAutoresizingMaskIntoConstraints = false
        itemRemainingLbl.translatesAutoresizingMaskIntoConstraints = false
        priceLbl.translatesAutoresizingMaskIntoConstraints = false
        choosenQuantityLbl.translatesAutoresizingMaskIntoConstraints = false
        plusBtn.translatesAutoresizingMaskIntoConstraints = false
        minusBtn.translatesAutoresizingMaskIntoConstraints = false
        xSign.translatesAutoresizingMaskIntoConstraints = false
        dolarSign.translatesAutoresizingMaskIntoConstraints = false
        
        choosenQuantityLbl.textAlignment = .center
        choosenQuantityLbl.font = UIFont.boldSystemFont(ofSize: 23)
        
        plusBtn.setTitle("+", for: .normal)
        plusBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 29)
        plusBtn.addTarget(self, action: #selector(plusBtnTapped), for: .touchUpInside)
        
        minusBtn.setTitle("-", for: .normal)
        minusBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 29)
        minusBtn.addTarget(self, action: #selector(minusBtnTapped), for: .touchUpInside)
        
        xSign.text = "x"
        
        dolarSign.text = "$"
        
        
        
    }
    
    func layout() {
        
        contentView.addSubview(itemImage)
        contentView.addSubview(itemLbl)
        contentView.addSubview(itemRemainingLbl)
        contentView.addSubview(priceLbl)
        contentView.addSubview(choosenQuantityLbl)
        contentView.addSubview(plusBtn)
        contentView.addSubview(minusBtn)
        contentView.addSubview(xSign)
        contentView.addSubview(dolarSign)
        
        NSLayoutConstraint.activate([
            // image
            itemImage.heightAnchor.constraint(equalToConstant: 110),
            itemImage.widthAnchor.constraint(equalToConstant: 140),
            itemImage.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            itemImage.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: itemImage.bottomAnchor, multiplier: 1),
            
            // title
            itemLbl.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 3),
            itemLbl.leadingAnchor.constraint(equalToSystemSpacingAfter: itemImage.trailingAnchor, multiplier: 2),
            
            // item Remaining
            itemRemainingLbl.centerYAnchor.constraint(equalTo: itemImage.centerYAnchor),
            itemRemainingLbl.leadingAnchor.constraint(equalTo: itemLbl.leadingAnchor),
            xSign.leadingAnchor.constraint(equalToSystemSpacingAfter: itemRemainingLbl.trailingAnchor, multiplier: 0.1),
            xSign.centerYAnchor.constraint(equalTo: itemRemainingLbl.centerYAnchor),
            
            // price
            bottomAnchor.constraint(equalToSystemSpacingBelow: priceLbl.bottomAnchor, multiplier: 3),
            priceLbl.leadingAnchor.constraint(equalTo: itemLbl.leadingAnchor),
            dolarSign.leadingAnchor.constraint(equalToSystemSpacingAfter: priceLbl.trailingAnchor, multiplier: 0.1),
            dolarSign.centerYAnchor.constraint(equalTo: priceLbl.centerYAnchor),
            
            // plus button
            plusBtn.heightAnchor.constraint(equalTo: choosenQuantityLbl.heightAnchor),
            plusBtn.widthAnchor.constraint(equalTo: choosenQuantityLbl.widthAnchor),
            trailingAnchor.constraint(equalToSystemSpacingAfter: plusBtn.trailingAnchor, multiplier: 3),
            plusBtn.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor),
            
            // choosen Quantity
            plusBtn.leadingAnchor.constraint(equalToSystemSpacingAfter: choosenQuantityLbl.trailingAnchor, multiplier: 0.1),
            choosenQuantityLbl.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor),
            
            
            minusBtn.heightAnchor.constraint(equalTo: choosenQuantityLbl.heightAnchor),
            minusBtn.widthAnchor.constraint(equalTo: choosenQuantityLbl.widthAnchor),
            choosenQuantityLbl.leadingAnchor.constraint(equalToSystemSpacingAfter: minusBtn.trailingAnchor, multiplier: 0.1),
            minusBtn.bottomAnchor.constraint(equalTo: itemImage.bottomAnchor),
            
            
            
        ])
        
        
        
    }
}
