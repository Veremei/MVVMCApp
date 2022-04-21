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
    func loginDidFinish()
}

final class LoginDefaulViewModel: LoginViewModel {
    private struct Constants {
        static let user = "user"
        static let password = "123qwe"
    }

    weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?

    func login(user: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if user == Constants.user && password == Constants.password {
                completion(.success(()))
            } else {
                completion(.failure(LoginError.incorrectCredentials))
            }
        }
    }

    func loginDidFinish() {
        coordinatorDelegate?.loginFlowSuccess()
    }
}
