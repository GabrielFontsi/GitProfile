//
//  Uiview + Extension.swift
//  GitProfile
//
//  Created by Gabriel Fontenele da Silva on 06/02/25.
//

import UIKit

/// Tag used to remove lock view when requested
private let backgroundViewTag = 3432

extension UIView {
    /// Blocks user interaction and add an animating view to represent a loading process
    func lock() {
        if let _ = self.viewWithTag(backgroundViewTag) {
            return
        }
        
        let backgroundView = UIView()
        backgroundView.layer.cornerRadius = layer.cornerRadius
        backgroundView.isUserInteractionEnabled = true
        backgroundView.isAccessibilityElement = true
        backgroundView.accessibilityLabel = "Carregando"
        backgroundView.tag = backgroundViewTag
        backgroundView.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        backgroundView.constraintFully(to: self)
        
        let refreshControll = UIActivityIndicatorView()
        refreshControll.color = .white
        refreshControll.constraintFully(to: backgroundView)
        refreshControll.startAnimating()
    }
    
    /// Removes animating view that represents a loading process
    func unlock() {
        guard let backgroundView = self.viewWithTag(backgroundViewTag) else {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            backgroundView.alpha = 0
        }) { (_) in
            backgroundView.removeFromSuperview()
        }
    }
}

extension UIView {
    
    func constraintFully(to view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func constraintFully(to view: UIView, top: CGFloat, bottom: CGFloat, leading: CGFloat, trailing: CGFloat) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
    }
    
    func constraintFully(to view: UIView, top: CGFloat, leading: CGFloat, trailing: CGFloat, bottomView: UIView, bottom: CGFloat) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
        
        view.addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: bottomAnchor, constant: top).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
    }

    func constraintsEqual(to view: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
    }

    func constraintsEqualToSafeArea(of view: UIView, top: CGFloat = 0, bottom: CGFloat = 0, leading: CGFloat = 0, trailing: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leading).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: trailing).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottom).isActive = true
    }
}
