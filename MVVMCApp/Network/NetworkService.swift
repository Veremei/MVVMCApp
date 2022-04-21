//
//  NetworkService.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 21.04.2022.
//

import Foundation

enum NetworkServiceError: Error {
    case missingResponseData
    case parsingFailed
    case commonError
}


class NetworkService {
    static let shared = NetworkService()

    private init() { }

    func request(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = endpoint.url else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkServiceError.missingResponseData))
                return
            }

            completion(.success(data))
        }.resume()
    }
}
