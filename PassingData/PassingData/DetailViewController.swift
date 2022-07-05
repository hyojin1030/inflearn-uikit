//
//  DetailViewController.swift
//  PassingData
//
//  Created by 주효진 on 2022/07/04.
//

import UIKit

class DetailViewController: UIViewController {

    // 인스턴스가 생성되는 시점에 해당 변수도 생성됨
    var someString = ""
    
    // 화면이 출력되는 시점(viewDidLoad)에 생성, 이전에 접근 시 nil
    @IBOutlet weak var someLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        someLabel.text = someString
    }
}
