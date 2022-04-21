//
//  LoginViewModel.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 20.04.2022.
//

import Foundation

enum LoginError: Error {
    case incorrectCredentials
}

protocol LoginViewModel {
    func login(user: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}

final class LoginDefaulViewModel: LoginViewModel {

    func login(user: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if user == "" && password == "" {
            completion(.success(()))
        } else {
            completion(.failure(LoginError.incorrectCredentials))
        }
    }
}
