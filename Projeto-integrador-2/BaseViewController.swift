//
//  BaseViewController.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 17/03/23.
//

import UIKit

class BaseViewController: UIViewController {

    private lazy var LogoutButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -4)
        button.target = self
        button.title = "Logout"
        button.action = #selector(LogoutButtonPressed)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = LogoutButton
        navigationController?.navigationBar.tintColor = UIColor(hex: "#AE52DE")
    }
    
    @objc func LogoutButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}
