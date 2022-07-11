//
//  DelegateDetailViewController.swift
//  PassingData
//
//  Created by 주효진 on 2022/07/11.
//

import UIKit

protocol DelegateDetailViewControllerDelegate: AnyObject {
    func passString(string: String)
    
}

class DelegateDetailViewController: UIViewController {

    weak var delegate: DelegateDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func passDataToMainVC(_ sender: Any) {
        delegate?.passString(string: "delegate pass Data")
        self.dismiss(animated: true, completion: nil)
    }
    
}
