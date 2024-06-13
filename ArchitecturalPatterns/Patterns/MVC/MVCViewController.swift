//
//  MVCViewController.swift
//  ArchitecturalPatterns
//
//  Created by Teyhan Uslu on 11.06.2024.
//

import UIKit

//Cocoa MVC:  https://developer.apple.com/library/archive/documentation/General/Conceptual/CocoaEncyclopedia/Model-View-Controller/Model-View-Controller.html

class MVCViewController: BaseViewController {
    var service:NetworkServiceProtocol?
    var characterList: [CharacterItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
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
        fetchChracters()
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
    
    func fetchChracters() {
        Task {
            do {
                guard let characterResult = try await service?.fetchCharacters() else {
                    showAlert(title: "Empty", message: nil)
                    return
                }
                self.characterList = characterResult.results ?? []
            } catch {
                showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }

}

extension MVCViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath)
        precondition(cell is CharacterCell, "Dequeued cell is not of MyCustomCell type")
        if let cell = cell as? CharacterCell {
            cell.configureCell(characterList[indexPath.row])
        }
        return cell
    }
}
