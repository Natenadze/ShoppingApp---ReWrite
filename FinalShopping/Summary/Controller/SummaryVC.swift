//
//  SummaryVC.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 09.05.23.
//

import UIKit

protocol SummaryVCDelegate: AnyObject {
    func updateStock()
}

class SummaryVC: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private let summaryView = SummaryView()
    private let payButton = UIButton(type: .system)
    
    let viewModel: SummaryVM
    
    
    weak var delegate: SummaryVCDelegate?
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        style()
        layout()
    }
    
    // MARK: - Init
    
    init(viewModel: SummaryVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: -  Selectors
    
    @objc func payButtonTapped() {
        if viewModel.success {
            delegate?.updateStock()
        }
        
        let vc = PaymentResultVC(image: viewModel.resultLogo, message: viewModel.resultMessage)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SummaryVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.basketModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SummaryCell.identifier, for: indexPath) as! SummaryCell
        
        cell.busketModel = viewModel.basketModel[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        106  // image height + paddings (top + bottom) / 110 + 8 + 8
    }
    
    
}


// MARK: - Style & Layout

extension SummaryVC {
    
    func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        payButton.translatesAutoresizingMaskIntoConstraints = false
        
        navigationController?.navigationBar.isHidden = false
        
        // Table View
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SummaryCell.self, forCellReuseIdentifier: SummaryCell.identifier)
        
        // summaryView
        
        summaryView.subTotalTextLbl.text = String(viewModel.subTotal)
        summaryView.vatTextLbl.text      = String(viewModel.vat)
        summaryView.deliveryTextLbl.text = String(viewModel.delivery)
        summaryView.TotalTextLbl.text    = String(viewModel.Total)
        
        // pay button
        
        payButton.setTitle("Pay", for: .normal)
        payButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        payButton.setTitleColor(.white, for: .normal)
        payButton.backgroundColor = .buttonCustomColor
        payButton.layer.cornerRadius = 6
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        
        
    }
    
    func layout() {
        view.addSubview(tableView)
        view.addSubview(summaryView)
        view.addSubview(payButton)
       
        
        NSLayoutConstraint.activate([
            
            // tableView
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: summaryView.topAnchor),
            
            // bottomView
            summaryView.heightAnchor.constraint(equalToConstant: 200),
            summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: summaryView.trailingAnchor),
            summaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            payButton.heightAnchor.constraint(equalToConstant: 50),
            payButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: payButton.trailingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: payButton.bottomAnchor, multiplier: 0.3)
        ])
    }
}
