//
//  CategoriesTableViewCell.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 07/09/22.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoriesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = .screenColor
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 0.2
    }
    
    func selectCell(activities: String) {
        categoriesLabel.text = activities.capitalized
        categoriesLabel.textColor = .systemBlue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
