//
//  InitialViewController.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 06/09/22.
//

import UIKit

class InitialViewController: BaseViewController {
    
    @IBOutlet weak var participantsTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    var activity: ActivitiesViewController = ActivitiesViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.isUserInteractionEnabled = false
        participantsTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        configureTextField()
        startButtonPressed()
        self.view.backgroundColor = .screenColor
        navigationController?.navigationBar.tintColor = UIColor(hex: "#AE52DE")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let participants = Int(participantsTextField.text!) else {
            startButton.isUserInteractionEnabled = false
            startButton.backgroundColor = .screenColor
            startButton.layer.borderWidth = 1
            return }
        if participants < 1 {
            startButton.isUserInteractionEnabled = false
            startButton.backgroundColor = .lightGray
            startButton.layer.borderWidth = 1.5
        } else {
            startButton.isUserInteractionEnabled = true
            startButton.backgroundColor = UIColor(hex: "#2197a3")
            startButton.layer.borderWidth = 1.5
        }
    }
    
    func configureTextField() {
        participantsTextField.layer.borderWidth = 1
        participantsTextField.placeholder = "Type number of participants here"
        participantsTextField.layer.cornerRadius = 10
    }
    
    func startButtonPressed() {
        startButton.layer.cornerRadius = 10
    }


    @IBAction func startButtonPressed(_ sender: Any) {
        let categoriesViewController = CategoriesViewController(nibName: "CategoriesViewController", bundle: nil)
        categoriesViewController.participants = Int(participantsTextField.text!)
        navigationController?.pushViewController(categoriesViewController, animated: true)
    }
    
    @IBAction func termsPressed(_ sender: Any) {
        let termsViewController = TermsViewController(nibName: "TermsViewController", bundle: nil)
        navigationController?.pushViewController(termsViewController, animated: true)
    }

}
