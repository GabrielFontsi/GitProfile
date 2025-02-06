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
    private let gitHubService: GitHubServiceProtocol
    
    init(gitHubService: GitHubServiceProtocol) {
        self.gitHubService = gitHubService
    }
    
    func fetchRepository(username: String) {
        let trimmedUsername = username.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedUsername.isEmpty else {
            delegate?.showAlert(title: "Atenção", message: "Digite um nome de usuário válido.")
            return
        }
        
        gitHubService.fetchRepositories(for: trimmedUsername) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                switch result {
                case .success(let repos):
                    if repos.isEmpty {
                        self.delegate?.showAlert(title: "Atenção", message: "Usuário não encontrado ou sem repositórios.")
                    } else {
                        self.delegate?.didFetchRepository(repos)
                    }
                    
                case .failure(let error):
                    print("Erro capturado: \(error.localizedDescription)")
                    
                    if let afError = error.asAFError, afError.isSessionTaskError {
                        self.delegate?.showAlert(title: "Erro de conexão", message: "Sem conexão com a internet. Verifique sua rede e tente novamente.")
                    } else {
                        self.delegate?.showAlert(title: "Atenção", message: "Erro ao buscar o perfil. Tente novamente.")
                    }
                }
            }
        }
    }
}
