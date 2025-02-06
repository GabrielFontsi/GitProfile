//
//  Repository.swift
//  GitProfile
//
//  Created by Gabriel Fontenele da Silva on 05/02/25.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let fullName: String
    let htmlUrl: String
    let language: String?
    let owner: Owner
    
    enum CodingKeys: String, CodingKey {
        case id, name, language
        case fullName = "full_name"
        case htmlUrl = "html_url"
        case owner
    }
}

struct Owner: Codable {
    let login: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}


