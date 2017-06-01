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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAppBar()
    }
    
    func initAppBar() {
        addChildViewController(appBar.headerViewController)
        
        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 12/255, green: 122/255, blue: 254/255, alpha: 0.7)
        //appBar.headerViewController.headerView.trackingScrollView = self.view
        appBar.navigationBar.tintColor = UIColor.black
        appBar.addSubviewsToParent()
        
        title = "Material forever!"
        
        let buttonFrame = CGRect(x: 0, y: 0, width: 30, height: 30)
    
        let searchButton: UIButton = UIButton(type: UIButtonType.custom)
        searchButton.setImage(UIImage(named: "Search"), for: UIControlState.normal)
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: UIControlEvents.touchUpInside)
        searchButton.frame = buttonFrame
        let searchBarButton = UIBarButtonItem(customView: searchButton)
        
        let settingsButton: UIButton = UIButton(type: UIButtonType.custom)
        settingsButton.setImage(UIImage(named: "Settings"), for: UIControlState.normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: UIControlEvents.touchUpInside)
        settingsButton.frame = buttonFrame
        let settingsBarButton = UIBarButtonItem(customView: settingsButton)
        
        self.navigationItem.rightBarButtonItems = [settingsBarButton, searchBarButton]
        
        // After all other views have been registered.
        appBar.addSubviewsToParent()
    }
    
    func settingsButtonPressed() {
        
    }
    
    func searchButtonPressed() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

