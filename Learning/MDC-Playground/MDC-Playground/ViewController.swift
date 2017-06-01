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
        appBar.headerViewController.headerView.backgroundColor = UIColor(red: 1.0, green: 0.76, blue: 0.03, alpha: 1.0)
        //appBar.headerViewController.headerView.trackingScrollView = self.view
        appBar.navigationBar.tintColor = UIColor.black
        appBar.addSubviewsToParent()
        
        title = "Material Components"
        
        
//        let searchBarButton = UIBarButtonItem(image: UIImage(named: "Search"), style: .done, target: self, action: #selector(searchButtonPressed))
        
        
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
        
//        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
//        negativeSpacer.width = -25;
//        
//        let settingsBarButton = UIBarButtonItem(image: UIImage(named: "Settings"), style: .done, target: self, action: #selector(settingsButtonPressed))
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

