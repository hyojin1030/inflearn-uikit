//
//  ViewController.swift
//  AppStart
//
//  Created by 주효진 on 2022/07/04.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btnTest: UIButton!
    
    @IBAction func doSomething(_ sender: Any) {
        btnTest.backgroundColor = .orange
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailVC") as DetailVC
        
        // present == intent
        self.present(detailVC, animated: true, completion: nil)
    }
    
    
    // ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // 인스턴스화 후 화면에 올릴 수 있을 때
        
        btnTest.backgroundColor = UIColor.red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 화면에 나오기 직전
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 화면에 나오고 난 후
    }

}

