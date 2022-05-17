//
//  LoginViewController.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 20.04.2022.
//

import UIKit

final class LoginViewController: UIViewController {
    @IBOutlet private var userTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!

    private var viewModel: LoginViewModel

    var userFieldIsEmpty: Bool {
        (userTextField.text ?? "").isEmpty
    }

    var passwordFieldIsEmpty: Bool {
        (passwordTextField.text ?? "").isEmpty
    }

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = "Login"
        loginButton.configuration?.imagePlacement = .trailing
        loginButton.configuration?.imagePadding = 8.0

        if let creds = viewModel.credentials {
            userTextField.text = creds.user
        }
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let user = userTextField.text,
              let password = passwordTextField.text else {
            return
        }
        startLoading()

        viewModel.login(user: user, password: password) { [weak self] result in
            guard let self = self else {
                return
            }

            self.finishLoading()

            switch result {
            case .success:
                self.loginButton.configuration?.image = UIImage(systemName: "checkmark",
                                                                withConfiguration: UIImage.SymbolConfiguration(scale: .large))

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.viewModel.loginDidFinish()
                }
            case .failure(let error):
                self.passwordTextField.text?.removeAll()
                self.presentAlert(with: error)
            }
        }
    }

    private func startLoading() {
        loginButton.configuration?.showsActivityIndicator = true
    }

    private func finishLoading() {
        loginButton.configuration?.showsActivityIndicator = false
    }

    private func presentAlert(with error: Error) {
        let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
