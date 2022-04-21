//
//  StringsListViewModel.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 20.04.2022.
//

import Foundation

protocol StringsListViewModel {
    var strings: [String] { get }
    func fetchData(completion: @escaping (Result<Void, Error>) -> Void)
}

final class StringsListDefaultViewModel: StringsListViewModel {

    private(set) var strings: [String] = []

    private var dataService: RandomStringsDataProtocol

    init(dataService: RandomStringsDataProtocol = RandomStringsDataService()) {
        self.dataService = dataService
    }

    func fetchData(completion: @escaping (Result<Void, Error>) -> Void) {
        dataService.loadStrings { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }

                switch result {
                case .success(let stringsResponse):
                    self.strings = stringsResponse
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
