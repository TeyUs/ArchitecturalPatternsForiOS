//
//  NetworkService.swift
//  ArchitecturalPatterns
//
//  Created by Teyhan Uslu on 11.06.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchCharacters() async throws -> Characters
}

class NetworkService: NetworkServiceProtocol {
    
    func fetchCharacters() async throws -> Characters {
        let response = try await URLSession.shared.data(from: URL(string: "https://rickandmortyapi.com/api/character")!)
        return try JSONDecoder().decode(Characters.self, from: response.0)
    }
}



enum NetworkError: Error {
    case resultsIsNil
}
