//
//  itemCell.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 09.05.23.
//

import UIKit
import Kingfisher

protocol ShoppingCellDelegate: AnyObject {
    
    func reloadData(forCell cell: UITableViewCell)
}


class ShoppingCell: UITableViewCell {
    
    // MARK: - Create Cell Identifier
    static var identifier: String {
        return String(describing: self)
    }

    // MARK: - Properties
    
    let itemImage = UIImageView()
    let itemTitle = UILabel()
    let stockLbl = UILabel()
    let priceLbl = UILabel()
    let choosenQuantityLbl = UILabel()
    
    let dolarSign = UILabel()
    let xSign = UILabel()
    
    let plusBtn = UIButton(type: .system)
    let minusBtn = UIButton(type: .system)
    
    
    // MARK: - CoreData Context
    let context = CoreDataManager.shared.viewContext
    
    // Main Data
    var cellData: Product! {
        didSet {
            setupCell()
        }
    }
    
    // Computed properties
    var choosenQuantity: Int {
        get {
            return cellData.choosenQuantity
        }
        set {
            cellData.choosenQuantity = newValue
        }
        
    }
    
    var remainingQuantity: Int {
        return Int(stockLbl.text!)!
    }
    
    var currentItem: Busket {
        get {
            let item = Busket(context: context)
            item.title = itemTitle.text!
            item.quantity = Int64(choosenQuantity)
            item.subTotal = priceLbl.text!
            item.image = itemImage.image!.pngData()
            
            return item
        }
    }
    
    // Delegate
    weak var delegate: ShoppingCellDelegate?

    
    
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
        let url = URL(string: cellData.thumbnail ?? "")
        itemImage.kf.setImage(with: url)
        
        choosenQuantityLbl.text = String(cellData.choosenQuantity)
        itemTitle.text = cellData.title
        priceLbl.text = String(cellData.price)
        stockLbl.text = String(cellData.stock)
    }
    
    // MARK: - Selectors
    
    @objc func plusBtnTapped() {
        
        if choosenQuantity < remainingQuantity {
            cellData.choosenQuantity = choosenQuantity + 1
        } else {
            return
        }
        createPlusNotification()
        delegate?.reloadData(forCell: self)
    }

    @objc func minusBtnTapped() {
        
        if choosenQuantity != 0 {
            cellData.choosenQuantity = choosenQuantity - 1
        } else {
            return
        }
        
        createMinusNotification()
        delegate?.reloadData(forCell: self)
    }
    
    func createPlusNotification() {
        let item = ["item": currentItem]
        NotificationCenter.default.post(name: .plusNotif, object: nil, userInfo: item)
        
    }
    
    func createMinusNotification() {
        let item = ["item": currentItem]
        NotificationCenter.default.post(name: .minusNotif, object: nil, userInfo: item)
        
    }

}


// MARK: - Style & Layout

extension ShoppingCell {
    
    func style1() {
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        itemTitle.translatesAutoresizingMaskIntoConstraints = false
        stockLbl.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(itemTitle)
        contentView.addSubview(stockLbl)
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
            itemTitle.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 3),
            itemTitle.leadingAnchor.constraint(equalToSystemSpacingAfter: itemImage.trailingAnchor, multiplier: 2),
            
            // item Remaining
            stockLbl.centerYAnchor.constraint(equalTo: itemImage.centerYAnchor),
            stockLbl.leadingAnchor.constraint(equalTo: itemTitle.leadingAnchor),
            xSign.leadingAnchor.constraint(equalToSystemSpacingAfter: stockLbl.trailingAnchor, multiplier: 0.1),
            xSign.centerYAnchor.constraint(equalTo: stockLbl.centerYAnchor),
            
            // price
            bottomAnchor.constraint(equalToSystemSpacingBelow: priceLbl.bottomAnchor, multiplier: 3),
            priceLbl.leadingAnchor.constraint(equalTo: itemTitle.leadingAnchor),
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



