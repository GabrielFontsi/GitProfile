//
//  RepositoryTableViewCell.swift
//  GitProfile
//
//  Created by Gabriel Fontenele da Silva on 05/02/25.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repositoryLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    var rep: Repository? {
        didSet {
            guard let rep else { return }
            repositoryLabel.text = rep.name
            languageLabel.text = rep.language ?? "Sem informação"
        }
    }
}
