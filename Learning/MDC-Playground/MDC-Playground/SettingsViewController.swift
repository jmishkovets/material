//
//  SeetingsViewController.swift
//  MDC-Playground
//
//  Created by Julia on 01.06.17.
//  Copyright © 2017 Julia. All rights reserved.
//

import UIKit

import MaterialComponents.MaterialCollections
import MaterialComponents.MaterialSnackbar

class SettingsViewController: MDCCollectionViewController {
    
    let reusableIdentifierItem = "itemCellIdentifier"
    let appBar = MDCAppBar()
    var content = [Int: [String]]()
    
    let appleBlue = UIColor(red: 12/255, green: 122/255, blue: 254/255, alpha: 0.7)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAppBar()
        
        self.collectionView?.register(MDCCollectionViewTextCell.self,
                                      forCellWithReuseIdentifier: reusableIdentifierItem)
        
        self.collectionView?.register(MDCCollectionViewTextCell.self,
                                      forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                      withReuseIdentifier: UICollectionElementKindSectionHeader)
        
        // Customize collection view settings.
        self.styler.cellStyle = .card
        
        content[0] = ["Public Profile", "Subscribe to Daily Digest"]
        content[1] = ["Get Email Notifications", "Get Text Notifications"]
    }
    
    func didTapBack() {
        dismiss(animated: true)
    }
    
    @objc fileprivate func didTapSwitch() {
        let message = MDCSnackbarMessage(text: "Are you sure?")
        let action = MDCSnackbarMessageAction()
        action.title = "Yes";
        message!.action = action;
        message!.buttonTextColor = UIColor.white
        
        MDCSnackbarManager.show(message)
    }
    
    func initAppBar() {
        addChildViewController(appBar.headerViewController)
        appBar.headerViewController.headerView.backgroundColor = appleBlue
        appBar.navigationBar.tintColor = UIColor.white
        appBar.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        appBar.headerViewController.headerView.trackingScrollView = self.collectionView
        appBar.addSubviewsToParent()
        
        let backButton = UIBarButtonItem(image: UIImage(named: "Back"), style: .done, target: self, action: #selector(didTapBack))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = nil
    }

}

// MARK: UICollectionViewDataSource

extension SettingsViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return content.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content[section]!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifierItem,
                                                      for: indexPath)
        if let cell = cell as? MDCCollectionViewTextCell {
            cell.textLabel?.text = content[indexPath.section]?[indexPath.item]
            let editingSwitch = UISwitch(frame: CGRect.zero)
            editingSwitch.addTarget(self, action: #selector(self.didTapSwitch), for: .valueChanged)
            cell.accessoryView = editingSwitch;
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryView: MDCCollectionViewTextCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kind, for: indexPath) as! MDCCollectionViewTextCell
        
        if kind == UICollectionElementKindSectionHeader {
            if indexPath.section == 0 {
                supplementaryView.textLabel?.text = "Account"
            } else if indexPath.section == 1 {
                supplementaryView.textLabel?.text = "Notification"
            }
            
            supplementaryView.textLabel?.textColor = appleBlue
        }
        
        return supplementaryView
    }
    
}

// MARK: UIScrollViewDelegate

extension SettingsViewController {
    
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

// MARK: UICollectionViewDelegateFlowLayout

extension SettingsViewController {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: MDCCellDefaultOneLineHeight)
    }
}

