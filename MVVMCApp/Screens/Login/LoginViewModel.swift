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
    func success()
}

protocol LoginViewModelCoordinatorDelegate: AnyObject {
    func loginSuccess()
}

final class LoginDefaulViewModel: LoginViewModel {
    weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?

    func login(user: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        if user == "user" && password == "123qwe" {
            completion(.success(()))
        } else {
            completion(.failure(LoginError.incorrectCredentials))
        }
    }

    func success() {
        coordinatorDelegate?.loginSuccess()
    }
}
