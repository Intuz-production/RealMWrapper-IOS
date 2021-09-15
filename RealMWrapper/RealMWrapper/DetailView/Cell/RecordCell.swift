//
//  RecordCell.swift
//  RealMWrapper
//
//  Created by Intuz on 14/09/21.
//

import UIKit

class RecordCell: UITableViewCell {

    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblMobileNo: UILabel!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
