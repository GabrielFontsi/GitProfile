//
//  ProfielDetailViewController.swift
//  GitProfile
//
//  Created by Gabriel Fontenele da Silva on 05/02/25.
//

import UIKit
import Kingfisher

class ProfileDetailViewController: UIViewController {
    
    var repositories: [Repository] = []
    
    init(repository: [Repository]) {
        
        self.repositories = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var profileDetailScreen = ProfileDetailScreen()
    
    override func loadView() {
        self.view = self.profileDetailScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setProfileDetail()
        self.profileDetailScreen.configTableViewDelegate(delegate: self, dataSource: self)
    }
    
    func setProfileDetail(){
        self.profileDetailScreen.usernameLabel.text = repositories.first?.owner.login
        
        if let avatarUrl = repositories.first?.owner.avatarUrl, let url = URL(string: avatarUrl) {
            self.profileDetailScreen.profileImageView.kf.setImage(with: url)
        }
    }
}

extension ProfileDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let repository = repositories[indexPath.row]
        cell.rep = repository
        cell.selectionStyle = .none
        return cell
    }
}
