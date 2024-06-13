//
//  VIPERInteractor.swift
//  ArchitecturalPatterns
//
//  Created by Teyhan Uslu on 13.06.2024.
//

import Foundation

class VIPERInteractor {
    let service: NetworkServiceProtocol
    var model: Characters?
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    func fetchCharacters() async throws {
        model = try await service.fetchCharacters()
    }
}
