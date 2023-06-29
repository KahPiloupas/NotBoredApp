//
//  Register.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 15/03/23.
//

import UIKit
import Firebase

class Register: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    var alert: Alert?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        alert = Alert(controller: self)
        self.view.backgroundColor = .screenColor
        navigationController?.navigationBar.tintColor = UIColor(hex: "#AE52DE")
    }
    
    func configureTextFields() {
        nameTextField.layer.borderWidth = 1
        nameTextField.placeholder = "Type your name here"
        nameTextField.layer.cornerRadius = 10
        nameTextField.delegate = self
        
        emailTextField.layer.borderWidth = 1
        emailTextField.placeholder = "Type your email here"
        emailTextField.layer.cornerRadius = 10
        emailTextField.delegate = self
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.placeholder = "Type your password here"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.delegate = self
        
        confirmPasswordTextField.layer.borderWidth = 1
        confirmPasswordTextField.layer.cornerRadius = 10
        confirmPasswordTextField.placeholder = "Confirm your password"
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.delegate = self
    }
    
    func validateEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    func validatePassword(password: String) -> Bool {
        let passWordRegEx = "^.{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passWordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    @IBAction func SaveButtonPressed(_ sender: Any) {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        var statusOk: Bool = true
        
        if name.count < 2 {
            statusOk = false
            nameTextField.layer.borderColor = UIColor.red.cgColor
        }
        
        if validateEmail(email: email) == false {
            statusOk = false
            emailTextField.layer.borderColor = UIColor.red.cgColor
        }
        
        if validatePassword(password: password) == false {
            statusOk = false
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
        }
        
        if confirmPassword != password {
            statusOk = false
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            confirmPasswordTextField.layer.borderColor = UIColor.red.cgColor
        }
        
        if statusOk {
            Auth.auth().createUser(withEmail: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "") { authResult, error in
                if error == nil {
                    self.alert?.showAlert(title: "Success!!", message: "Successful Register!") {
                        self.nameTextField.text = ""
                        self.emailTextField.text = ""
                        self.passwordTextField.text = ""
                        self.confirmPasswordTextField.text = ""
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                } else {
                    self.alert?.showAlert(title: "❌", message: error?.localizedDescription ?? "")
                }
            }
        } else {
            self.alert?.showAlert(title: "🚨", message: "Some fields are empty!")
            
        }
    }
}

extension Register: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.black.cgColor
    }
}

extension UIColor {
    convenience init(hex: String) {
        var formattedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if formattedHex.count == 6 {
            formattedHex = "FF" + formattedHex
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: formattedHex).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        let alpha = CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    static let screenColor = UIColor(hex: "#b6d8c0")
}

