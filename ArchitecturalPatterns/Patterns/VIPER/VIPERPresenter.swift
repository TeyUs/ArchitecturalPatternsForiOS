//
//  VIPERPresenter.swift
//  ArchitecturalPatterns
//
//  Created by Teyhan Uslu on 13.06.2024.
//

import Foundation

class VIPERPresenter {
    let view: VIPERViewController
    let interactor: VIPERInteractor
    let router: VIPERRouter
    
    init(view: VIPERViewController, interactor: VIPERInteractor, router: VIPERRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func fetchModel() {
        Task {
            do {
                try await interactor.fetchCharacters()
//                DispatchQueue.main.async { [weak self] in
//                    self?.view.reloadData()
//                }
                await view.reloadData()
            } catch {
                await view.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
}

extension VIPERPresenter {
    func viewDidLoad() {
        fetchModel()
    }
    
    func numberOfListCount() -> Int {
        interactor.model?.results?.count ?? 0
    }
    
    func itemOfList(_ indexPath: IndexPath) -> CharacterItem? {
        interactor.model?.results?[indexPath.row]
    }
}
