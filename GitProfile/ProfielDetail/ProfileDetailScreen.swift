//
//  ProfileDetailScreen.swift
//  GitProfile
//
//  Created by Gabriel Fontenele da Silva on 05/02/25.
//

import UIKit

class ProfileDetailScreen: UIView {
    
    lazy var profileImageView: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 60
        return img
    }()
    
    lazy var usernameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .black
        return lb
    }()
    
    lazy var repositoryTableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(type:RepositoryTableViewCell.self)
        tv.backgroundColor = .clear
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupBackground()
        self.setupAddSubView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configTableViewDelegate(delegate: UITableViewDelegate, dataSource: UITableViewDataSource){
        self.repositoryTableView.delegate = delegate
        self.repositoryTableView.dataSource = dataSource
    }
    
    private func setupBackground(){
        self.backgroundColor = .systemGray6
    }
    
    private func setupAddSubView(){
        self.addSubview(self.profileImageView)
        self.addSubview(self.usernameLabel)
        self.addSubview(self.repositoryTableView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            self.profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.profileImageView.heightAnchor.constraint(equalToConstant: 120),
            self.profileImageView.widthAnchor.constraint(equalToConstant: 120),
            
            self.usernameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 8),
            self.usernameLabel.centerXAnchor.constraint(equalTo: self.profileImageView.centerXAnchor),
                        
            self.repositoryTableView.topAnchor.constraint(equalTo: self.usernameLabel.bottomAnchor, constant: 4),
            self.repositoryTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.repositoryTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.repositoryTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
