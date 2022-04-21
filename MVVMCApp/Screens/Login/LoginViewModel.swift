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
    var credentials: LoginCredentials? { get }
    func login(user: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func loginDidFinish()
}

final class LoginDefaulViewModel: LoginViewModel {
    private struct Constants {
        static let user = "user"
        static let password = "123qwe"
    }

    var credentials: LoginCredentials?

    init(credentials: LoginCredentials? = nil) {
        self.credentials = credentials
    }

    weak var coordinatorDelegate: LoginViewModelCoordinatorDelegate?

    func login(user: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        credentials = LoginCredentials(user: user, password: password)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else {
                return
            }

            if user == Constants.user && password == Constants.password {
                completion(.success(()))
            } else {
                self.credentials?.password = ""
                completion(.failure(LoginError.incorrectCredentials))
            }
        }
    }

    func loginDidFinish() {
        coordinatorDelegate?.loginFlowSuccess()
    }
}
