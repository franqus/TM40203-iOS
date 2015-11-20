//
//  ADMDetailTableViewCell.swift
//  ADMInformationRetriever
//
//  Created by Frank Schmitt on 19.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMDetailTableViewCell: UITableViewCell {

	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var tvContent: UITextView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
