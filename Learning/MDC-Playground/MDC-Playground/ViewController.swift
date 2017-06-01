//
//  ViewController.swift
//  MDC-Playground
//
//  Created by Julia on 01.06.17.
//  Copyright © 2017 Julia. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialAppBar

class ViewController: UIViewController {
    
    let appBar = MDCAppBar()
    let appleBlue = UIColor(red: 12/255, green: 122/255, blue: 254/255, alpha: 0.7)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAppBar()
    }
    
    func initAppBar() {
        addChildViewController(appBar.headerViewController)
        
        appBar.headerViewController.headerView.backgroundColor = appleBlue
        //appBar.headerViewController.headerView.trackingScrollView = self.view
        appBar.navigationBar.tintColor = UIColor.white
        appBar.addSubviewsToParent()
        
        title = "MD forever!"
        
        let buttonFrame = CGRect(x: 0, y: 0, width: 30, height: 30)
    
        let searchButton: UIButton = UIButton(type: UIButtonType.custom)
        searchButton.setImage(UIImage(named: "Search"), for: UIControlState.normal)
        searchButton.addTarget(self, action: #selector(didTapSearch), for: UIControlEvents.touchUpInside)
        searchButton.frame = buttonFrame
        let searchBarButton = UIBarButtonItem(customView: searchButton)
        
        let settingsButton: UIButton = UIButton(type: UIButtonType.custom)
        settingsButton.setImage(UIImage(named: "Settings"), for: UIControlState.normal)
        settingsButton.addTarget(self, action: #selector(didTapSettings), for: UIControlEvents.touchUpInside)
        settingsButton.frame = buttonFrame
        let settingsBarButton = UIBarButtonItem(customView: settingsButton)
        
        self.navigationItem.rightBarButtonItems = [settingsBarButton, searchBarButton]
        
        // After all other views have been registered.
        appBar.addSubviewsToParent()
    }
    
    func didTapSettings() {
        let settingsViewController = SettingsViewController()
        settingsViewController.title = "Settings"
        
        let navigationController = UINavigationController(rootViewController: settingsViewController)
        navigationController.navigationBar.barTintColor = appleBlue
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController.navigationBar.isTranslucent = false
        navigationController.isNavigationBarHidden = true
        
        present(navigationController, animated: true, completion: nil)
    }
    
    func didTapSearch() {
        
    }
    
    func closeViewController() {
        dismiss(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

