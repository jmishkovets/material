//
//  ViewController.swift
//  MDC-Tutorial
//
//  Created by Julia on 31.05.17.
//  Copyright © 2017 Julia. All rights reserved.
//

import UIKit

import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialCollections

class ViewController: MDCCollectionViewController {
    
    private let appBar = MDCAppBar()
    private let floatingButton = MDCFloatingButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        styler.cellStyle = .card
        
        initAppBar()
        initfloatingButton()
    }
    
    func initAppBar() {
        addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.76, blue: 0.03, alpha: 1.0)
        appBar.headerViewController.headerView.trackingScrollView = self.collectionView
        appBar.navigationBar.tintColor = UIColor.black
        appBar.addSubviewsToParent()
        
        title = "Material Components"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(ViewController.barButtonDidTap(_:)))
    }
    
    @objc func barButtonDidTap(_ sender: UIBarButtonItem) {
        editor.isEditing = !editor.isEditing
        
        let buttonTitle =  editor.isEditing ? "Cancel" : "Edit"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(ViewController.barButtonDidTap(_:)))
    }
    
    func initfloatingButton() {
        view.addSubview(floatingButton)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0).isActive = true
        
        floatingButton.setTitle("+", for: .normal)
        floatingButton.setTitle("-", for: .selected)
        floatingButton.setTitleColor(.white, for: .normal)
        floatingButton.setTitleColor(.white, for: .selected)
        floatingButton.addTarget(self, action: #selector(ViewController.floatingButtonDidTap(_:)), for: .touchUpInside)
    }
    
    @objc func floatingButtonDidTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}

// MARK: UICollectionViewDataSource

extension ViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // Add some mock text to the cell.
        if let textCell = cell as? MDCCollectionViewTextCell {
            let animals = ["Lions", "Tigers", "Bears", "Monkeys"]
            textCell.textLabel?.text = animals[indexPath.item]
        }
        
        return cell
    }

}

// MARK: UIScrollViewDelegate

extension ViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
            appBar.headerViewController.headerView.trackingScrollDidScroll()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == appBar.headerViewController.headerView.trackingScrollView {
            appBar.headerViewController.headerView.trackingScrollDidEndDecelerating()
        }
    }

}
