//
//  MyIDViewController.swift
//  Setting_Clone_App
//
//  Created by 주효진 on 2022/09/07.
//

import UIKit

class MyIDViewController: UIViewController {
    @IBOutlet weak var cancelButton: UIButton!
    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = false
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
    
    @objc func textFieldDidChange(sender: UITextField) {
        if sender.text?.isEmpty == true {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }

}
