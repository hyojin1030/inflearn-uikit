//
//  ViewController.swift
//  CustomRotateButton
//
//  Created by 주효진 on 2022/09/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var customButton1: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customButton1.selectTypeCallback = { upDownType in
            print(upDownType)
        }
        
//        let myButton = CustomButton()
//
//        self.view.addSubview(myButton)
//        myButton.translatesAutoresizingMaskIntoConstraints = false
//        myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        myButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        myButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
//        myButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        myButton.backgroundColor = UIColor.orange
//        myButton.setTitle("my custom button", for: .normal)
//        myButton.setImage(UIImage.init(systemName: "arrow.clockwise.heart"), for: .normal)
    }


}

