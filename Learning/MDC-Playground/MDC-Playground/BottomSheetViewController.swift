//
//  BottomSheetViewController.swift
//  MDC-Playground
//
//  Created by Julia on 04.06.17.
//  Copyright © 2017 Julia. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var gripView: UIView!
    
    let alpha: CGFloat = 0.7
    let minHeight: CGFloat = 56
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let panGesture = UIPanGestureRecognizer.init(target: self, action: #selector(didPanGesture))
        view.addGestureRecognizer(panGesture)
        
        gripView.alpha = alpha
        
        //gripView.backgroundColor = AppDelegate.appleBlue
        
        roundViewCorners()
    }
    
    func didPanGesture(panGestureRecognizer: UIPanGestureRecognizer) {
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
    
    func roundViewCorners() {
        view.layer.cornerRadius = 5
        gripView.layer.cornerRadius = 3
        view.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBackgorund() // todo: causes multiple view creation if settings are choosen
    }
    
    func setupBackgorund() {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            let frame = self?.view.frame
            let indent = UIScreen.main.bounds.height - (self?.minHeight)!
            self?.view.frame = CGRect(x: 0, y: indent, width: frame!.width, height: frame!.height)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
