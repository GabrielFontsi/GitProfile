//
//  HomeViewController.swift
//  GitProfile
//
//  Created by Gabriel Fontenele da Silva on 05/02/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var homeScreen = HomeScreen()
    private var viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.homeScreen
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.homeScreen.delegate(delegate: self)
        self.homeScreen.configTextFieldDelegate(delegate: self)
    }
    
    func setupNavigationBar(){
        title = "Git Profile"
    }
}

extension HomeViewController: HomeScreenProtocol {
    func actionSearchButton() {
        view.lock()
        guard let username = homeScreen.usernameTextField.text else { return }
        viewModel.fetchRepository(username: username)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func showAlert(title: String, message: String) {
        view.unlock()
        UIAlertController.showAlert(on: self, title: title, message: message)
    }
    
    func didFetchRepository(_ repository: [Repository]) {
        view.unlock()
        let profileVC = ProfileDetailViewController(repository: repository)
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
}

