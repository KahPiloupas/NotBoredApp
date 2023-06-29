//
//  Login.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 15/03/23.
//

import UIKit
import Firebase

class Login: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var alert: Alert?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        alert = Alert(controller: self)
        self.view.backgroundColor = UIColor(hex: "#b6d8c0")
    }
    
    func configureTextField() {
        emailTextField.layer.borderWidth = 1
        emailTextField.placeholder = "Type your email here"
        emailTextField.layer.cornerRadius = 10
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.placeholder = "Type your password here"
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.isSecureTextEntry = true
    }
    
    func tryLogin(email: String, password: String, completion: @escaping (String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error == nil {
                completion ("Success")
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            } else {
                completion (error?.localizedDescription ?? "")
            }
        }
    }
    @IBAction func LoginButtonPressed(_ sender: Any) {
        tryLogin(email: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "") { resultLogin in
            if resultLogin == "Success" {
                self.alert?.showAlert(title: "Success!!", message: "Let's Play!") {
                    let initialViewController = InitialViewController(nibName: "InitialViewController", bundle: nil)
                    self.navigationController?.pushViewController(initialViewController, animated: true)
                }
            } else {
                self.alert?.showAlert(title: "Ops!!", message: resultLogin)
            }
        }
    }
    
    @IBAction func RegisterButtonPressed(_ sender: Any) {
        let viewController: Register? = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(withIdentifier: "Register") as? Register
        navigationController?.pushViewController(viewController ?? UIViewController(), animated: true)
    }
}
