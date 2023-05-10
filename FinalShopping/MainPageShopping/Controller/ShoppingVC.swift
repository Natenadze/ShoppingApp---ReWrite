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
    
    private let viewModel: ShoppingVM
    
    var sectionitems: [[Product]]? {
        didSet {
            tableView.reloadData()
            activityIndicator.stopAnimating()
        }
    }
   
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        style()
        layout()
        
        
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
        
        viewModel.fetchData(withUrl: url) { items in
            self.sectionitems = items
        }
        
    }
    
    // MARK: - Selectors
    
    @objc func goToSummaryTapped() {
        let vc = SummaryVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - Table View

extension ShoppingVC: UITableViewDataSource, UITableViewDelegate {
    
    //
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionitems?.count ?? 0
    }

    //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sectionitems?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! itemCell
        
        guard let data = sectionitems?[indexPath.section][indexPath.row] else { return cell}
        cell.setupCell(withData: data) // Inject Data to Cell Itself
        
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
        
        label.text = sectionitems?[section][0].category.uppercased()
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
        tableView.register(itemCell.self, forCellReuseIdentifier: "cell")
        
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
