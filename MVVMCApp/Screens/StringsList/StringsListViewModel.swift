//
//  StringsListViewModel.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 20.04.2022.
//

import Foundation

protocol StringsListViewDelegate: AnyObject {
    func didLoadData()
    func loadingFailed(with error: Error)
}

protocol StringsListViewModel {
    var strings: [String] { get }
    var delegate: StringsListViewDelegate? { get set }
    func fetchData()
}

final class StringsListDefaultViewModel: StringsListViewModel {

    private(set) var strings: [String] = []

    private var networkService: NetworkService

    weak var delegate: StringsListViewDelegate?

    init(networkService: NetworkService = NetworkService.shared) {
        self.networkService = networkService
    }

    func fetchData() {
        let endpoint = RandomStringURLBuilder.build()

        networkService.request(endpoint: endpoint) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }

                switch result {
                case .success(let data):
                    guard let dataString = String(data: data, encoding: .utf8) else {
                        self.delegate?.loadingFailed(with: NetworkServiceError.parsingFailed)
                        return
                    }

                    self.strings = dataString
                        .split(whereSeparator: \.isNewline)
                        .map(String.init)
                    self.delegate?.didLoadData()
                case .failure(let error):
                    self.delegate?.loadingFailed(with: error)
                }
            }
        }
    }
}
