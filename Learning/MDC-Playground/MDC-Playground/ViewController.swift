//
//  ViewController.swift
//  MDC-Playground
//
//  Created by Julia on 01.06.17.
//  Copyright © 2017 Julia. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialAppBar
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let appBar = MDCAppBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAppBar()
        initMap()
    }
    
    func initAppBar() {
        addChildViewController(appBar.headerViewController)
        
        appBar.headerViewController.headerView.backgroundColor = AppDelegate.appleBlue
        //appBar.headerViewController.headerView.trackingScrollView = self.view
        appBar.navigationBar.tintColor = UIColor.white
        appBar.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        appBar.addSubviewsToParent()
        
        title = "MD forever!"
        
//        let buttonFrame = CGRect(x: 0, y: 0, width: 30, height: 30)
//    
//        let searchButton: UIButton = UIButton(type: UIButtonType.custom)
//        searchButton.setImage(UIImage(named: "Search"), for: UIControlState.normal)
//        searchButton.addTarget(self, action: #selector(didTapSearch), for: UIControlEvents.touchUpInside)
//        searchButton.frame = buttonFrame
//        let searchBarButton = UIBarButtonItem(customView: searchButton)
//        
//        let settingsButton: UIButton = UIButton(type: UIButtonType.custom)
//        settingsButton.setImage(UIImage(named: "Settings"), for: UIControlState.normal)
//        settingsButton.addTarget(self, action: #selector(didTapSettings), for: UIControlEvents.touchUpInside)
//        settingsButton.frame = buttonFrame
//        let settingsBarButton = UIBarButtonItem(customView: settingsButton)
//        
//        self.navigationItem.rightBarButtonItems = [settingsBarButton, searchBarButton]
        
        let settingsBarButton = UIBarButtonItem(image: UIImage(named: "Settings"), style: .done, target: self, action: #selector(didTapSettings))
        self.navigationItem.rightBarButtonItem = settingsBarButton
        
        // After all other views have been registered.
        appBar.addSubviewsToParent()
    }
    
    func initMap() {
        // Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(location: initialLocation)
        
        // Drop a pin
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = initialLocation.coordinate
        dropPin.title = "Honolulu"
        mapView.addAnnotation(dropPin)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheet()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func didTapSettings() {
        let settingsViewController = SettingsViewController()
        settingsViewController.title = "Settings"
        
        let navigationController = UINavigationController(rootViewController: settingsViewController)
        navigationController.navigationBar.barTintColor = AppDelegate.appleBlue
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController.navigationBar.isTranslucent = false
        navigationController.isNavigationBarHidden = true
        
        present(navigationController, animated: true, completion: nil)
    }
    
    func closeViewController() {
        dismiss(animated: true)
    }
    
    func addBottomSheet() {
        let bottomSheetViewController = BottomSheetViewController()
        
        self.addChildViewController(bottomSheetViewController)
        self.view.addSubview(bottomSheetViewController.view)
        bottomSheetViewController.didMove(toParentViewController: self)
        bottomSheetViewController.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }

}

