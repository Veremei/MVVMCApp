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

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let user = userTextField.text,
              let password = passwordTextField.text else {
                  return
              }

        viewModel.login(user: user, password: password) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case .success():
                self.viewModel.success()
            case .failure(_):
                print("")
            }
        }
    }
}
