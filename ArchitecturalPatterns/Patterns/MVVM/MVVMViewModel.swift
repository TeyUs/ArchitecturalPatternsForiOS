//
//  MVVMViewModel.swift
//  ArchitecturalPatterns
//
//  Created by Teyhan Uslu on 12.06.2024.
//

import Foundation

class MVVMViewModel {
    var service:NetworkServiceProtocol?
    
    var reloadData: (() -> Void)?
    private var characterList: [CharacterItem] = [] {
        didSet {
            reloadData?()
        }
    }
    
    var showAlert: ((_ title: String, _ message: String?) -> Void)?
    private var alertInfo: (title: String, message: String?)? {
        didSet {
            showAlert?(alertInfo?.0 ?? "", alertInfo?.1)
        }
    }
    
    func fetchChracters() {
        Task {
            do {
                guard let characterResult = try await service?.fetchCharacters() else {
                    alertInfo = ("Empty", nil)
                    return
                }
                self.characterList = characterResult.results ?? []
            } catch {
                alertInfo = ("Error", error.localizedDescription)
            }
        }
    }
    
    init(service: NetworkServiceProtocol? = NetworkService()) {
        self.service = service
    }
    
    func numberOfListCount() -> Int {
        characterList.count
    }
    
    func itemOfList(_ indexPath: IndexPath) -> CharacterItem {
        characterList[indexPath.row]
    }
}
