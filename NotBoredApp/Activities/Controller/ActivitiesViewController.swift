//
//  ActivitiesViewController.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 07/09/22.
//

import UIKit

class ActivitiesViewController: BaseViewController {
    
    @IBOutlet weak var Activity: UILabel!
    @IBOutlet weak var Participants: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var apiManager: BoredManager?
    var actvType: String = ""
    var alert: Alert?
    var participants: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBoredManager()
        configActivityIndicator()
        alert = Alert(controller: self)
        self.view.backgroundColor = .screenColor
    }
    
    private func configBoredManager() {
        apiManager = BoredManager()
        apiManager?.delegate = self
        apiManager?.fetchBored(of: participants ?? 1, type: actvType)
    }
    
    private func configActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}

extension ActivitiesViewController: BoredManagerDelegate {
    func didUpdateBored(_ boredManager: BoredManager, bored: BoredModel) {
        DispatchQueue.main.async {
            self.Activity.text = bored.activity
            self.Participants.text = "\(bored.participants)"
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.alert?.showAlert(title: "Ops!!", message: "Activity not found!")
            self.navigationController?.popViewController(animated: true)
        }
    }
}
