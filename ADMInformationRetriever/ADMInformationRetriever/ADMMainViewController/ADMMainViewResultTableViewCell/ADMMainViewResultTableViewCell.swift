//
//  ADMMainViewResultTableViewCell.swift
//  ADMInformationRetriever
//
//  Created by Frank Schmitt on 22.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMMainViewResultTableViewCell: UITableViewCell {

	@IBOutlet weak var lblRank: UILabel!
	@IBOutlet weak var lblTitle: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
