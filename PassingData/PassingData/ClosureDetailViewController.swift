//
//  ClosureDetailViewController.swift
//  PassingData
//
//  Created by 주효진 on 2022/07/11.
//

import UIKit

class ClosureDetailViewController: UIViewController {
    
    var myClosure: ((String) -> Void)?
    
    @IBAction func closurePassData(_ sender: Any) {
        myClosure?("closure string")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
