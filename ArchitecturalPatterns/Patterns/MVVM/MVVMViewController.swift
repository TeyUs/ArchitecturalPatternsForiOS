//
//  MVVMViewController.swift
//  ArchitecturalPatterns
//
//  Created by Teyhan Uslu on 12.06.2024.
//

import UIKit

class MVVMViewController: BaseViewController {
    lazy var viewModel: MVVMViewModel = {
        return MVVMViewModel()
    }()
    
    private lazy var tableView: UITableView = {
        let temp = UITableView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.delegate = self
        temp.dataSource = self
        let nib = UINib(nibName: CharacterCell.identifier, bundle: nil)
        temp.register(nib, forCellReuseIdentifier: CharacterCell.identifier)
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        initViewModel()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func initViewModel() {
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.showAlert = { [weak self] title, message in
            self?.showAlert(title: title, message: message)
        }
        
        viewModel.fetchChracters()
    }
}

extension MVVMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath)
        if let cell = cell as? CharacterCell{
            cell.configureCell(viewModel.itemOfList(indexPath))
        }
        return cell
    }
}

