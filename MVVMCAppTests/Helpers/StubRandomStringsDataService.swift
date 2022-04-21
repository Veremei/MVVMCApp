//
//  FakeRandomStringsDataService.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 21.04.2022.
//

import Foundation


final class StubRandomStringsDataService: RandomStringsDataProtocol {
    var requestResult: Result<[String], Error>?

    func loadStrings(completion: @escaping (Result<[String], Error>) -> Void) {
        completion(requestResult!)
    }
    
}
