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
    var informationRepository: [Repository]?
    
    init(repository: [Repository]) {
        
        self.informationRepository = repository
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
        self.fetchRepository()
        self.profileDetailScreen.configTableViewDelegate(delegate: self, dataSource: self)
    }
    
    func fetchRepository(){
        guard let repository = informationRepository else {return}
        self.profileDetailScreen.usernameLabel.text = repository.first?.owner.login
        
        if let avatarUrl = repository.first?.owner.avatarUrl, let url = URL(string: avatarUrl) {
            self.profileDetailScreen.profileImageView.kf.setImage(with: url)
        }
    }
}

extension ProfileDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationRepository?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RepositoryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let repository = informationRepository?[indexPath.row]
        cell.rep = repository
        cell.selectionStyle = .none
        return cell
    }
}
