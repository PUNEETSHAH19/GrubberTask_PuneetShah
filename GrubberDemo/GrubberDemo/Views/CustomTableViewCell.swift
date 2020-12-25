//
//  CustomTableViewCell.swift
//  GrubberDemo
//
//  Created by Puneet Shah on 25/12/20.
//  Copyright © 2020 Puneet Shah. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDate : UILabel!
    @IBOutlet weak var labelTitle : UILabel!
    @IBOutlet weak var labelCategory : UILabel!
    @IBOutlet weak var labelAmount : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
