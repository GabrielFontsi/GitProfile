//
//  HomeViewController.swift
//  GitProfile
//
//  Created by Gabriel Fontenele da Silva on 05/02/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var homeScreen = HomeScreen()
    
    override func loadView() {
        self.view = self.homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTitle()
        self.homeScreen.delegate(delegate: self)
        self.homeScreen.configTextFieldDelegate(delegate: self)
    }
    
    func setupTitle(){
        title = "Git Profile"
    }
}

extension HomeViewController: HomeScreenProtocol {
    func actionSearchButton() {
        guard let username = self.homeScreen.usernameTextField.text, !username.trimmingCharacters(in: .whitespaces).isEmpty else {
            UIAlertController.showAlert(on: self, title: "Atenção", message: "Digite um nome de usuário válido.")
            return
        }
        
        GitHubService.shared.fetchRepositories(for: username) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let repos):
                    if repos.isEmpty {
                        UIAlertController.showAlert(on: self, title: "Atenção", message: "Usuário não encontrado ou sem repositórios.")
                    } else {
                        let profileVC = ProfileDetailViewController(username: username, urlProfile: repos.first?.owner.avatarUrl ?? "", fullName: repos.first?.owner.login ?? "Sem nome")
                        self.navigationController?.pushViewController(profileVC, animated: true)
                    }
                case .failure:
                    UIAlertController.showAlert(on: self, title: "Atenção", message: "Erro ao buscar o perfil. Tente novamente.")
                }
            }
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

