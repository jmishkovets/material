//
//  ViewController.swift
//  MDC-Playground
//
//  Created by Julia on 01.06.17.
//  Copyright © 2017 Julia. All rights reserved.
//

import UIKit
import MapKit

import MaterialComponents.MaterialAppBar
import MaterialComponents.MaterialButtons

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    private let _appBar = MDCAppBar()
    private let _navigationButton = MDCFloatingButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppBar()
        setupMap()
        setupBottomSheet()
        setupNavigationButton()
    }
    
    private func setupAppBar() {
        addChildViewController(_appBar.headerViewController)
        
        _appBar.headerViewController.headerView.backgroundColor = AppDelegate.appleBlue
        _appBar.navigationBar.tintColor = UIColor.white
        _appBar.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        _appBar.addSubviewsToParent()
        
        title = "MD forever!"

        let settingsBarButton = UIBarButtonItem(image: UIImage(named: "Settings"), style: .done, target: self, action: #selector(didTapSettings))
        self.navigationItem.rightBarButtonItem = settingsBarButton
        
        // After all other views have been registered.
        _appBar.addSubviewsToParent()
    }
    
    private func setupMap() {
        // Location of Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(location: initialLocation)
        
        // Drop a pin
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = initialLocation.coordinate
        dropPin.title = "Honolulu"
        mapView.addAnnotation(dropPin)
    }
    
    private func setupBottomSheet() {
        let bottomSheetViewController = BottomSheetViewController()
        
        self.addChildViewController(bottomSheetViewController)
        self.view.addSubview(bottomSheetViewController.view)
        bottomSheetViewController.didMove(toParentViewController: self)
        bottomSheetViewController.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    private func setupNavigationButton() {
        view.addSubview(_navigationButton)
        _navigationButton.translatesAutoresizingMaskIntoConstraints = false
        _navigationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0).isActive = true
        _navigationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -28.0).isActive = true
        _navigationButton.setImage(UIImage(named: "Directions"), for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc private func didTapSettings() {
        let settingsViewController = SettingsViewController()
        settingsViewController.title = "Settings"
        
        let navigationController = UINavigationController(rootViewController: settingsViewController)
        navigationController.navigationBar.barTintColor = AppDelegate.appleBlue
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController.navigationBar.isTranslucent = false
        navigationController.isNavigationBarHidden = true
        
        present(navigationController, animated: true, completion: nil)
    }
    
    private func closeViewController() {
        dismiss(animated: true)
    }

}

