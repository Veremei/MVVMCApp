//
//  NetworkServiceFake.swift
//  MVVMCAppTests
//
//  Created by Daniil Veramei on 21.04.2022.
//

import Foundation

final class NetworkServiceFake: NetworkServiceProtocol {
    var requestResult: Result<Data, Error>?

    func request(endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        completion(requestResult!)
    }
}
