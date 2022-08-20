//
//  CreateAnswerViewController.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/20.
//

import UIKit

private let trueFalseCellIdentifier = "TrueFalseAnswerCell"
private let essayCellIdentifier = "EssayAnswerCell"

class CreateAnswerViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var answerType = [String]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedTrueFalseButton() {
        answerType.append(trueFalseCellIdentifier)
        
    }
    
    @IBAction func pressedEssayButton() {
        answerType.append(essayCellIdentifier)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreateAnswerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerType.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = answerType[indexPath.row]
        if cellIdentifier == trueFalseCellIdentifier {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: answerType[indexPath.row], for: indexPath) as? TrueFalseTableViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: answerType[indexPath.row], for: indexPath) as? EssayTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "아래 버튼을 눌러 문제를 만들어보세요."
    }

}
