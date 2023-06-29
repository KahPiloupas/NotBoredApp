//
//  CategoriesViewController.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 07/09/22.
//

import UIKit

class CategoriesViewController: BaseViewController {
    
    @IBOutlet weak var categoriesList: UITableView!
    
    
    @IBOutlet weak var randomButton: UIButton!
    
    var newCategories = [String]()
    var activity: BoredModel?
    var participants: Int?
    var alert: Alert?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newCategories = parseJson()
        categoriesList.dataSource = self
        categoriesList.delegate = self
        categoriesList.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        categoriesList.separatorStyle = .none
        
        self.view.backgroundColor = .screenColor
        categoriesList.backgroundColor = .clear
        randomButton.tintColor = UIColor(hex: "#AE52DE")
    }
    
    @IBAction func randomButton(_ sender: UIButton) {
        newCategories.shuffle()
        categoriesList.reloadData()
        categoriesList.layoutIfNeeded()
    }
    
    func parseJson() -> [String] {
        if let url = Bundle.main.url(forResource: "categories", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Categories.self, from: data)
                return jsonData.categories
            }
            catch {
                self.alert?.showAlert(title: "Ops!!", message: "Failed to decode!")
            }
        }
        return []
    }
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CategoriesTableViewCell else {
            return UITableViewCell()
        }
        cell.selectCell(activities: newCategories[indexPath.row])
        return cell
    }
}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewcController = UIStoryboard(name: "ActivitiesViewController", bundle: nil).instantiateViewController(withIdentifier: "ActivitiesViewController") as? ActivitiesViewController {
            viewcController.actvType = newCategories[indexPath.row]
            viewcController.title = newCategories[indexPath.row]
            viewcController.participants = participants
            self.navigationController?.pushViewController(viewcController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}
