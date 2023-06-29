//
//  Alert.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 15/03/23.
//

import UIKit

class Alert {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okay = UIAlertAction(title: "OK", style: .default) { action in
            completion?()
        }
        alertController.addAction(okay)
        controller.present(alertController, animated: true, completion: nil)
    }
}
