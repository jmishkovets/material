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
    
    fileprivate let _reusableCellIdentifier = "itemCellIdentifier"
    fileprivate let _appBar = MDCAppBar()
    fileprivate var _content = [Int: [String]]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppBar()
        setupCollectionView()
    }
    
    private func setupAppBar() {
        addChildViewController(_appBar.headerViewController)
        _appBar.headerViewController.headerView.backgroundColor = AppDelegate.appleBlue
        _appBar.navigationBar.tintColor = UIColor.white
        _appBar.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        _appBar.headerViewController.headerView.trackingScrollView = self.collectionView
        _appBar.addSubviewsToParent()
        
        let backButton = UIBarButtonItem(image: UIImage(named: "Back"), style: .done, target: self, action: #selector(didTapBack))
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = nil
    }
    
    @objc private func didTapBack() {
        dismiss(animated: true)
    }
    
    private func setupCollectionView() {
        self.collectionView?.register(MDCCollectionViewTextCell.self,
                                      forCellWithReuseIdentifier: _reusableCellIdentifier)
        
        self.collectionView?.register(MDCCollectionViewTextCell.self,
                                      forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                      withReuseIdentifier: UICollectionElementKindSectionHeader)
        
        // Customize collection view settings.
        self.styler.cellStyle = .card
        
        _content[0] = ["Public Profile", "Subscribe to Daily Digest"]
        _content[1] = ["Get Email Notifications", "Get Text Notifications"]
    }
    
    @objc fileprivate func didTapSwitch() {
        let message = MDCSnackbarMessage(text: "Are you sure?")
        let action = MDCSnackbarMessageAction()
        action.title = "Yes";
        message!.action = action;
        message!.buttonTextColor = UIColor.white
        
        MDCSnackbarManager.show(message)
    }

}

// MARK: UICollectionViewDataSource

extension SettingsViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return _content.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _content[section]!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: _reusableCellIdentifier,
                                                      for: indexPath)
        if let cell = cell as? MDCCollectionViewTextCell {
            cell.textLabel?.text = _content[indexPath.section]?[indexPath.item]
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
            
            supplementaryView.textLabel?.textColor = AppDelegate.appleBlue
        }
        
        return supplementaryView
    }
    
}

// MARK: UIScrollViewDelegate

extension SettingsViewController {
    
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

// MARK: UICollectionViewDelegateFlowLayout

extension SettingsViewController {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: MDCCellDefaultOneLineHeight)
    }
}

