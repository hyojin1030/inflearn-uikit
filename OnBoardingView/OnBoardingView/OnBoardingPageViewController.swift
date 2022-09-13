//
//  OnBoardingPageViewController.swift
//  OnBoardingView
//
//  Created by 주효진 on 2022/09/13.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {

    var pages = [UIViewController]()
    var bottomButtonMargin: NSLayoutConstraint?
    var pageControl = UIPageControl()
    
    let startIndex = 0
    var currentIndex = 0 {
        didSet {
            pageControl.currentPage = currentIndex
        }
    }
    
    func makePageVC() {
        let itemVC1 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC1.mainText = "title - first"
        itemVC1.subText = "sub - first first first first first first first first first first first first first first first first first first first first "
        itemVC1.topImage = UIImage(named: "onboarding1")
        let itemVC2 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC2.mainText = "title - second"
        itemVC2.subText = "sub - second second second second second second second second second second second second second second second second second"
        itemVC2.topImage = UIImage(named: "onboarding2")
        let itemVC3 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC3.mainText = "title - third"
        itemVC3.subText = "sub - third third third third third third third third third third third third third third third third third third third third"
        itemVC3.topImage = UIImage(named: "onboarding3")
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        
        setViewControllers([itemVC1], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self
        self.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makePageVC()
        self.makeBottomButton()
        self.makePageControl()
        
    }

    func makeBottomButton() {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.systemBlue
    
        button.addTarget(self, action: #selector(dismissPageVC), for: .touchUpInside)
        
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomButtonMargin = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomButtonMargin?.isActive = true
        
        hideButton()
    }
    
    @objc func dismissPageVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func makePageControl() {
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = startIndex
        
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
        
    }
    
    @objc func pageControlTapped(sender: UIPageControl) {
        if sender.currentPage < self.currentIndex {
            self.setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        } else {
            self.setViewControllers([pages[sender.currentPage]], direction: .reverse, animated: true, completion: nil)
        }
        
        self.currentIndex = sender.currentPage
        
        buttonPresentationStyle()
    }
    
}

extension OnBoardingPageViewController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        self.currentIndex = currentIndex
        
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
        

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        self.currentIndex = currentIndex
        
        if currentIndex == pages.count - 1 {
            return pages.first
        } else {
            return pages[currentIndex + 1]
        }
    }
}

extension OnBoardingPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
                
        guard let currentVC = pageViewController.viewControllers?.first else {
            return
        }
        
        guard let currentIndex = pages.firstIndex(of: currentVC) else {
            return
        }
        
        self.currentIndex = currentIndex
        
        buttonPresentationStyle()
        
    }
    
    func buttonPresentationStyle() {
        if currentIndex == pages.count - 1 {
            self.showButton()
        } else {
            self.hideButton()
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)

    }
    
    func showButton() {
        bottomButtonMargin?.constant = 0
    }
    
    func hideButton() {
        bottomButtonMargin?.constant = 100
    }
}
