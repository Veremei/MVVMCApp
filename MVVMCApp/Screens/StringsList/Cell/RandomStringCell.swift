//
//  RandomStringCell.swift
//  MVVMCApp
//
//  Created by Daniil Veramei on 21.04.2022.
//

import UIKit

class RandomStringCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setTitle(text: String) {
        titleLabel.text = text
    }
}
