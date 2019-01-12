//
//  RankTableViewCell.swift
//  Snake
//
//  Created by User08 on 2019/1/6.
//  Copyright © 2019 AutumnCAT. All rights reserved.
//

import UIKit

class RankTableViewCell: UITableViewCell {
    
    @IBOutlet weak var NOLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
