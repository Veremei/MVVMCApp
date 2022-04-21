//
//  RandomStringsDataService.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 21.04.2022.
//

import Foundation

protocol RandomStringsDataProtocol {
    func loadStrings(completion: @escaping (Result<[String], Error>) -> Void)
}

final class RandomStringsDataService: RandomStringsDataProtocol {

    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }

    func loadStrings(completion: @escaping (Result<[String], Error>) -> Void) {
        let endpoint = RandomStringURLBuilder.build()

        networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                guard let dataString = String(data: data, encoding: .utf8) else {
                    completion(.failure(NetworkServiceError.parsingFailed))
                    return
                }

                let strings = dataString
                    .split(whereSeparator: \.isNewline)
                    .map(String.init)
                completion(.success(strings))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
