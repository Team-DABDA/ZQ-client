//
//  EssayTableViewCell.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/20.
//

import UIKit

protocol EssayDelegate {
    func questionTextFieldValueChanged(cell: UITableViewCell, textField: UITextField)
    func answerTextFieldValueChanged(cell: UITableViewCell, textField: UITextField)
}

class EssayTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!

    var delegate: EssayDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension EssayTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.questionTextFieldValueChanged(cell: self, textField: questionTextField)
        delegate?.answerTextFieldValueChanged(cell: self, textField: questionTextField)
    }
}
