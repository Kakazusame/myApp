//
//  customWordCellTableViewCell.swift
//  myApp
//
//  Created by 嘉数涼夏 on 2018/02/09.
//  Copyright © 2018年 Suzuka Kakazu. All rights reserved.
//

import UIKit

class customWordCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var judgeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
