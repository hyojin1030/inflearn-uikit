//
//  ViewController.swift
//  OnBoardingView
//
//  Created by 주효진 on 2022/09/13.
//

import UIKit

class ViewController: UIViewController {
    
    var didShowOnboardingView = false

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if didShowOnboardingView == false {
            didShowOnboardingView = true
            let pageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
            pageVC.modalPresentationStyle = .fullScreen
            self.present(pageVC, animated: true)
        }
    
    }


}

