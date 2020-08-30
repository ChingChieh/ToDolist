//
//  TodoCell.swift
//  ToDoList
//
//  Created by ChingChieh on 2020/8/30.
//  Copyright © 2020 ChingChieh. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var checkmarkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
