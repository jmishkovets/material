//
//  ViewController.swift
//  MDC-Tutorial
//
//  Created by Julia on 31.05.17.
//  Copyright © 2017 Julia. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCollections
import MaterialComponents.MaterialAppBar

class ViewController: MDCCollectionViewController {
    
    let appBar = MDCAppBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        styler.cellStyle = .card
        
        initAppBar()
    }
    
    func initAppBar() {
        addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.76, blue: 0.03, alpha: 1.0)
        appBar.headerViewController.headerView.trackingScrollView = self.collectionView
        appBar.navigationBar.tintColor = UIColor.black
        appBar.addSubviewsToParent()
        
        title = "Material Components"
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

