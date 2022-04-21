//
//  LoginViewModel.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 20.04.2022.
//

import Foundation

enum LoginError: LocalizedError {
    case incorrectCredentials

    var errorDescription: String? {
        switch self {
        case .incorrectCredentials:
            return "Incorrect credentials"
        }
    }
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
