//
//  GeneralViewController.swift
//  Setting_Clone_App
//
//  Created by 주효진 on 2022/08/26.
//

import UIKit

class GeneralCell: UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView! {
        didSet{
            rightImageView.image = UIImage.init(systemName: "chevron.right")
        }
    }
    
}

struct GeneralModel {
    var leftTitle = ""
}


class GeneralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = [[GeneralModel]]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    @IBOutlet weak var generalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generalTableView.delegate = self
        generalTableView.dataSource = self
        
        GeneralModel.init(leftTitle: "About")
        GeneralModel.init(leftTitle: "Keyboard")
        GeneralModel.init(leftTitle: "Game Controller")
        GeneralModel.init(leftTitle: "Fonts")
        GeneralModel.init(leftTitle: "Languege & Region")
        GeneralModel.init(leftTitle: "Dictionary")
        GeneralModel.init(leftTitle: "Reset")
        

    }
    
}
