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

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }

                if let _ = error {
                    return
                }

                guard let data = data else {
                    return
                }

                guard let dataString = String(data: data, encoding: .utf8) else {
                    return
                }
                self.strings = dataString
                    .split(whereSeparator: \.isNewline)
                    .map(String.init)
                self.delegate?.didLoadData()
            }
        }.resume()
    }

}
