//
//  MVPViewController.swift
//  ArchitecturalPatterns
//
//  Created by Teyhan Uslu on 12.06.2024.
//

import UIKit

class MVPViewController: BaseViewController {
    var presenter: MVPPresenter?
    
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
        presenter = MVPPresenter(view: self)
        presenter?.viewDidLoad()
        setupView()
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
}

extension MVPViewController: MVPPresenterView {
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension MVPViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfListCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath)
        if let cell = cell as? CharacterCell,
           let model = presenter?.itemOfList(indexPath) {
            cell.configureCell(model)
        }
        return cell
    }
}

