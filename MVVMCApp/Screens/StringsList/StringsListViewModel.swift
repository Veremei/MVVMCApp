//
//  StringsListViewModel.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 20.04.2022.
//

import Foundation

protocol StringsListViewDelegate: AnyObject {
    func didLoadData()
}

protocol StringsListViewModel {
    var strings: [String] { get }
    var delegate: StringsListViewDelegate? { get set }
    func fetchData()
}

final class StringsListDefaultViewModel: StringsListViewModel {

    private(set) var strings: [String] = []

    weak var delegate: StringsListViewDelegate?

    func fetchData() {
        guard let url = URL(string: "https://www.random.org/strings/?num=10&len=8&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new") else {
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                return
            }

            if let _ = error {
//                completion(.failure(error))
            }

            guard let data = data else {
                return
            }

            do {
                self.strings = try JSONDecoder().decode([String].self, from: data)
                self.delegate?.didLoadData()
            } catch {
//                completion(.failure(error))
            }

        }.resume()
    }

}
