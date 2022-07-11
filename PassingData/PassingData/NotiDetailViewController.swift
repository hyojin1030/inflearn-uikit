//
//  NotiDetailViewController.swift
//  PassingData
//
//  Created by 주효진 on 2022/07/11.
//

import UIKit

class NotiDetailViewController: UIViewController {

    @IBAction func notiAction(_ sender: Any) {
        
        let notificationName = Notification.Name("sendSomeString")
        
        let strDic = ["str" : "noti string"]

        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: strDic)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
