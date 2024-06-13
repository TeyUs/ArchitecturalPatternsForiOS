//
//  MVPPresenter.swift
//  ArchitecturalPatterns
//
//  Created by Teyhan Uslu on 12.06.2024.
//

import Foundation

protocol MVPPresenterView: AnyObject {
    func reloadData()
    func showAlert(title: String, message: String?)
}

class MVPPresenter {
    var service:NetworkServiceProtocol?
    weak var view: MVPPresenterView?
    
    private var characterList: [CharacterItem] = [] {
        didSet {
            view?.reloadData()
        }
    }
    
    init(service: NetworkServiceProtocol? = NetworkService(), view: MVPPresenterView?) {
        self.service = service
        self.view = view
    }
    
    func viewDidLoad() {
        fetchChracters()
    }
    
    func fetchChracters() {
        Task {
            do {
                guard let characterResult = try await service?.fetchCharacters() else {
                    view?.showAlert(title: "Empty", message: nil)
                    return
                }
                self.characterList = characterResult.results ?? []
            } catch {
                view?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    func numberOfListCount() -> Int {
        characterList.count
    }
    
    func itemOfList(_ indexPath: IndexPath) -> CharacterItem {
        characterList[indexPath.row]
    }
    
}
