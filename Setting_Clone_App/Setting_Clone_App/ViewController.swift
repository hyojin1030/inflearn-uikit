//
//  ViewController.swift
//  Setting_Clone_App
//
//  Created by 주효진 on 2022/08/11.
//

import UIKit

class MainController: UIViewController {
    
    var settingModel = [[SettingModel]]()

    @IBOutlet weak var settingTableView: UITableView!

    func makeData() {
        settingModel.append([SettingModel(leftImageName: "person.circle", menuTitle: "Sign in to your iPhone", subTitle: "Set up iCloud, the App Store, and more.", rightImageName: nil)])
        
        settingModel.append(
            [SettingModel(leftImageName: "gear", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right"),
             SettingModel(leftImageName: "person.fill", menuTitle: "Accessibility", subTitle: nil, rightImageName: "chevron.right"),
             SettingModel(leftImageName: "hand.raised.fill", menuTitle: "Privacy", subTitle: nil, rightImageName: "chevron.right")]
        )
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.backgroundColor = UIColor(white: 245/255, alpha: 1)
        settingTableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
    
        title = "Settings"
        self.view.backgroundColor = UIColor(white: 245/255, alpha: 1)
        
        makeData()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingModel[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingModel.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let myidVC = MyIDViewController(nibName: "MyIDViewController", bundle: nil)
            
            self.present(myidVC, animated: true)
        }
        
        else if indexPath.section == 1 && indexPath.row == 0 {
            if let generalVC = UIStoryboard(name: "GeneralViewController", bundle: nil).instantiateViewController(identifier: "GeneralViewController") as? GeneralViewController {
                self.navigationController?.pushViewController(generalVC, animated: true)
            }
                        
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            
            cell.profileImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
            
            cell.topTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
            
            cell.bottonDescription.text = settingModel[indexPath.section][indexPath.row].subTitle
            
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.leftImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
        cell.leftImageView.tintColor = .red
        cell.rightImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].rightImageName ?? "")
        cell.middleTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableView.automaticDimension
        }
        
        return 60
    }
    
}

