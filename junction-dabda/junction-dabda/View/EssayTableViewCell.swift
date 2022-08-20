//
//  EssayTableViewCell.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/20.
//

import UIKit

class EssayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
