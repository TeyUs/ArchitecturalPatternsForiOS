//
//  VIPERRouter.swift
//  ArchitecturalPatterns
//
//  Created by Teyhan Uslu on 13.06.2024.
//

import Foundation

class VIPERRouter {
    let service: NetworkServiceProtocol
    
    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
    }
    
    func build() -> BaseViewController {
        let view = VIPERViewController()
        let interactor = VIPERInteractor(service: service)
        let presenter = VIPERPresenter(view: view, interactor: interactor, router: self)
        view.presenter = presenter
        return view
    }
}
