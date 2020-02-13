//
//  FriendsCell.swift
//  SnapchatClone
//
//  Created by Max Miranda on 9/20/19.
//  Copyright © 2019 ___MaxAMiranda___. All rights reserved.
//

import UIKit

class FriendsCell: UITableViewCell {

    var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel = UILabel(frame: CGRect(x: 20, y: 8, width: contentView.frame.width - 80, height: 30))
        contentView.addSubview(nameLabel)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
