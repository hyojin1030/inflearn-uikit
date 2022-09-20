//
//  TodoCell.swift
//  TodoList
//
//  Created by 주효진 on 2022/09/20.
//

import UIKit

class TodoCell: UITableViewCell {
    @IBOutlet weak var priorityView: UIView!
    @IBOutlet weak var topTitleLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
