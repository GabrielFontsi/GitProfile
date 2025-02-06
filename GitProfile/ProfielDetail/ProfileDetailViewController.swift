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
    var username: String?
    var url: String?
    var fullName: String?
    
    init(username: String, urlProfile: String, fullName: String) {
        self.username = username
        self.url = urlProfile
        self.fullName = fullName
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
        
        self.fetchRepositories()
        self.profileDetailScreen.configTableViewDelegate(delegate: self, dataSource: self)
    }
    
    func fetchRepositories() {
        guard let username = self.username, !username.isEmpty else {
            print("Username inválido!")
            return
        }
        
        GitHubService.shared.fetchRepositories(for: username) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let repos):
                    self.repositories = repos
                    print("Repositórios carregados: \(repos.count)")
                    self.profileDetailScreen.repositoryTableView.reloadData()
                    self.profileDetailScreen.usernameLabel.text = self.fullName
                    
                    if let avatarUrl = self.url, let url = URL(string: avatarUrl) {
                        self.profileDetailScreen.profileImageView.kf.setImage(with: url)
                    }
                    
                case .failure:
                    print("Erro ao buscar os repositórios")
                    UIAlertController.showAlert(on: self, title: "Erro", message: "Falha ao carregar repositórios.")
                }
            }
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
