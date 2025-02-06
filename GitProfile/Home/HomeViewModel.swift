//
//  HomeViewModel.swift
//  GitProfile
//
//  Created by Gabriel Fontenele da Silva on 06/02/25.
//

import Alamofire

protocol HomeViewModelDelegate: AnyObject {
    func didFetchRepository(_ repository: [Repository])
    func showAlert(title: String, message: String)
}

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    func fetchRepository(username: String)
}

class HomeViewModel: HomeViewModelProtocol {
    
    weak var delegate: HomeViewModelDelegate?
    private let gitHubService: GitHubService
    
    init(gitHubService: GitHubService) {
        self.gitHubService = gitHubService
    }
    
    func fetchRepository(username: String) {
        let trimmedUsername = username.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedUsername.isEmpty else {
            delegate?.showAlert(title: "Atenção", message: "Digite um nome de usuário válido.")
            return
        }
        
        gitHubService.fetchRepositories(for: trimmedUsername) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let repos):
                    if repos.isEmpty {
                        self.delegate?.showAlert(title: "Atenção", message: "Usuário não encontrado ou sem repositórios.")
                    } else {
                        self.delegate?.didFetchRepository(repos)
                    }
                case .failure:
                    self.delegate?.showAlert(title: "Atenção", message: "Erro ao buscar o perfil. Tente novamente.")
                }
            }
        }
    }
}
