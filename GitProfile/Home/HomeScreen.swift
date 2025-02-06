//
//  HomeScreen.swift
//  GitProfile
//
//  Created by Gabriel Fontenele da Silva on 05/02/25.
//

import UIKit

protocol HomeScreenProtocol:AnyObject {
    func actionSearchButton()
}

class HomeScreen: UIView {
    
    private weak var delegate: HomeScreenProtocol?
    
    func delegate(delegate:HomeScreenProtocol?){
        self.delegate = delegate
    }
    
    lazy var usernameTextField: UITextField = {
        var tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 1
        tf.backgroundColor = .systemGray6
        tf.layer.borderColor = UIColor.lightGray.cgColor
        tf.textColor = .lightGray
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 8
        tf.placeholder = " Username"
        
        return tf
    }()
    
    lazy var searchButton: UIButton = {
        var bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
        bt.setTitle("Search", for: .normal)
        bt.setTitleColor(UIColor.systemBlue, for: .normal)
        return bt
    }()
    
    @objc private func tappedSearchButton(){
        self.delegate?.actionSearchButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupBackground()
        self.setupAddSubView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate){
        self.usernameTextField.delegate = delegate
    }
    
    private func setupBackground(){
        self.backgroundColor = .systemGray6
        
    }
    
    private func setupAddSubView(){
        self.addSubview(self.usernameTextField)
        self.addSubview(self.searchButton)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            self.usernameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.usernameTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -32),
            self.usernameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 32),
            self.usernameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            self.usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.searchButton.topAnchor.constraint(equalTo: self.usernameTextField.bottomAnchor, constant: 8),
            self.searchButton.leadingAnchor.constraint(equalTo: self.usernameTextField.leadingAnchor),
            self.searchButton.trailingAnchor.constraint(equalTo: self.usernameTextField.trailingAnchor),
            self.searchButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
