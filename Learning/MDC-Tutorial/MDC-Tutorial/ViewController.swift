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
    
    fileprivate let _appBar = MDCAppBar()
    private let _floatingButton = MDCFloatingButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        styler.cellStyle = .card
        
        initAppBar()
        initfloatingButton()
    }
    
    func initAppBar() {
        addChildViewController(_appBar.headerViewController)
        _appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.76, blue: 0.03, alpha: 1.0)
        _appBar.headerViewController.headerView.trackingScrollView = self.collectionView
        _appBar.navigationBar.tintColor = UIColor.black
        _appBar.addSubviewsToParent()
        
        title = "Material Components"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(ViewController.barButtonDidTap(_:)))
    }
    
    func barButtonDidTap(_ sender: UIBarButtonItem) {
        editor.isEditing = !editor.isEditing
        
        let buttonTitle =  editor.isEditing ? "Cancel" : "Edit"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(ViewController.barButtonDidTap(_:)))
        _floatingButton.setTitle("+", for: .normal)
        _floatingButton.setTitle("-", for: .selected)
        _floatingButton.addTarget(self, action: #selector(ViewController.floatingButtonDidTap(_:)), for: .touchUpInside)
    }
    
    func initfloatingButton() {
        view.addSubview(_floatingButton)
        _floatingButton.translatesAutoresizingMaskIntoConstraints = false
        _floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        _floatingButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0).isActive = true
    }
    
    func floatingButtonDidTap(_ sender: UIButton) {
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
        if scrollView == _appBar.headerViewController.headerView.trackingScrollView {
            _appBar.headerViewController.headerView.trackingScrollDidScroll()
        }
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == _appBar.headerViewController.headerView.trackingScrollView {
            _appBar.headerViewController.headerView.trackingScrollDidEndDecelerating()
        }
    }

}
