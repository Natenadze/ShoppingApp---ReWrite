//
//  ShoppingVC.swift
//  FinalShopping
//
//  Created by Davit Natenadze on 08.05.23.
//

import UIKit

class ShoppingVC: UIViewController {
    
    
    // MARK: - Properties
    private let tableView = UITableView()
    private let bottomView = ShoppingBottomView()
    private let goToSummaryBtn = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var viewModel: ShoppingVM
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        style()
        layout()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        
    }
    
    // MARK: - Init
    
    init(viewModel: ShoppingVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    
    func setupData() {
        let url = "https://dummyjson.com/products"
        viewModel.fetchData(withUrl: url)
        
    }
    
    // MARK: - Selectors
    
    @objc func goToSummaryTapped() {
        
        let basket = CoreDataManager.shared.fetchBusket()
        let vm = SummaryVM(busketModel: basket)
        let vc = SummaryVC(viewModel: vm)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Delegate Methods

extension ShoppingVC: ShoppingCellDelegate, ShoppingVMDelegate {
    
    // ShoppingVMDelegate
    func updateView() {
        tableView.reloadData()
        activityIndicator.stopAnimating()
        bottomView.quantityLbl.text = viewModel.totalQuantity
        bottomView.priceLbl.text = viewModel.totalPrice
    }
    
    // ShoppingCellDelegate
    
    func reloadCellData(forCell cell: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        bottomView.quantityLbl.text = viewModel.totalQuantity
        bottomView.priceLbl.text = viewModel.totalPrice
    }
    
    
}

// MARK: - Table View

extension ShoppingVC: UITableViewDataSource, UITableViewDelegate {
    
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.getNumberOfSections
    }
    
    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getNumberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCell.identifier, for: indexPath) as! ShoppingCell
        
        cell.delegate = self
        let data = viewModel.sectionitems?[indexPath.section][indexPath.row]
        cell.cellData = data
        
        
        return cell
    }
    
    //
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        126  // image height + paddings (top + bottom) / 110 + 8 + 8
    }
    
    
    // MARK: - Header
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = UIColor.systemTeal
        
        let label = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.width - 20, height: 30))
        
        label.text = viewModel.sectionitems(section: section)
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = UIColor.white
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    //
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}


extension ShoppingVC: SummaryVCDelegate {
    
    func updateStock() {
        
        viewModel.updateMainBase()
        viewModel.basket.forEach { item in
            CoreDataManager.shared.deleteBusketItem(item)
        }
        updateView()
    }
    
    
}


// MARK: - Style & Layout

extension ShoppingVC {
    
    func style() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        goToSummaryBtn.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        // tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ShoppingCell.self, forCellReuseIdentifier: ShoppingCell.identifier)
        
        // activity indicator
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        
        // button
        goToSummaryBtn.addTarget(self, action: #selector(goToSummaryTapped), for: .touchUpInside)
        
    }
    
    func layout() {
        view.addSubview(tableView)
        bottomView.addSubview(goToSummaryBtn)
        view.addSubview(bottomView)
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            // tableView
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            
            // bottomView
            bottomView.heightAnchor.constraint(equalToConstant: 130),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            
            goToSummaryBtn.topAnchor.constraint(equalTo: bottomView.topAnchor),
            goToSummaryBtn.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor),
            goToSummaryBtn.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor),
            goToSummaryBtn.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor)
            
        ])
        
    }
    
}




