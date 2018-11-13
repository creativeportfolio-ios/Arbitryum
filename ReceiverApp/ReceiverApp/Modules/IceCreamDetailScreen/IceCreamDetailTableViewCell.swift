//
//  IceCreamDetailTableViewCell.swift
//  ReceiverApp
//
//  Created by Nick on 12/11/18.
//  Copyright © 2018 Nick. All rights reserved.
//

import UIKit

class IceCreamDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var iceCreamNameLabel: UILabel!
    @IBOutlet weak var iceCreamFlavourLabel: UILabel!
    @IBOutlet weak var iceCreamColorLabel: UILabel!
    @IBOutlet weak var iceCreamTemperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
