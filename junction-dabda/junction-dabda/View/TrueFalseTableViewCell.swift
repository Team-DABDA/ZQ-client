//
//  TrueFalseTableViewCell.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/20.
//

import UIKit

protocol TrueFalseDelegate {
    func textFieldValueChanged(cell: UITableViewCell, textField: UITextField)
    func segmentedValueChanged(cell: UITableViewCell, segmented: UISegmentedControl)
}

class TrueFalseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerSegmentedControl: UISegmentedControl!
    
    var delegate: TrueFalseDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func segmentedControlValueChanged() {
        delegate?.segmentedValueChanged(cell: self, segmented: answerSegmentedControl)
    }

}

extension TrueFalseTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldValueChanged(cell: self, textField: questionTextField)
    }
}
