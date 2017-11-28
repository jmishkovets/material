//
//  BottomSheetViewController.swift
//  MDC-Playground
//
//  Created by Julia on 04.06.17.
//  Copyright © 2017 Julia. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet private weak var gripView: UIView!
    
    private let alpha: CGFloat = 0.6
    private let minHeight: CGFloat = 56
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(didPanGesture))
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(didTapGesture))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        gripView.alpha = alpha
        
        roundViewCorners()
        
        setupBackgorund()
    }
    
    @objc private func didPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: self.view)
        let minY = self.view.frame.minY
        var newY = minY + translation.y
        let limitY = UIScreen.main.bounds.height - minHeight
        if newY > limitY {
            newY = limitY
        }
        self.view.frame = CGRect(x: 0, y: newY, width: view.frame.width, height: view.frame.height)
        panGestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    @objc private func didTapGesture(tapGestureRecognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            let frame = self?.view.frame
            self?.view.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.size.height, width: frame!.width, height: frame!.height)
        }
    }
    
    private func roundViewCorners() {
        view.layer.cornerRadius = 5
        gripView.layer.cornerRadius = 3
        view.clipsToBounds = true
    }
    
    private func setupBackgorund() {
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        visualEffect.alpha = alpha
        bluredView.alpha = alpha
        bluredView.contentView.addSubview(visualEffect)
        
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        
        view.insertSubview(bluredView, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let frame = view.frame
        let indent = UIScreen.main.bounds.height - minHeight
        self.view.frame = CGRect(x: 0, y: indent, width: frame.width, height: frame.height)
        self.view.isHidden = false
    }

}
