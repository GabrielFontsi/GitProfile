//
//  GitService.swift
//  GitProfile
//
//  Created by Gabriel Fontenele da Silva on 05/02/25.
//

import Alamofire

protocol GitHubServiceProtocol {
    func fetchRepositories(for username: String, completion: @escaping (Result<[Repository], Error>) -> Void)
}

enum NetworkError: Error {
    case noInternet
    case other(Error)
}

class GitHubService: GitHubServiceProtocol {
    
    func fetchRepositories(for username: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
        let url = "https://api.github.com/users/\(username)/repos"
        
        AF.request(url).validate().responseDecodable(of: [Repository].self) { response in
            switch response.result {
            case .success(let repositories):
                completion(.success(repositories))
            case .failure(let error):
                if let afError = error.asAFError, let responseCode = response.response?.statusCode {
                    if responseCode == 404 {
                        completion(.success([]))
                    } else {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
}

