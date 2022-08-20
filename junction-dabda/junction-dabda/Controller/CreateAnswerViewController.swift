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
    
    var quizModel =  NewQuizModel(title: "", quizScore: 0, quizQuestion: [])

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func pressedTrueFalseButton() {
        answerType.append(trueFalseCellIdentifier)
        quizModel.quizQuestion.append(QuizInfoModel(type: "t-f", content: "", answer: "true"))
    }
    
    @IBAction func pressedEssayButton() {
        answerType.append(essayCellIdentifier)
        quizModel.quizQuestion.append(QuizInfoModel(type: "short-answer", content: "", answer: ""))
    }
    
    @IBAction func pressedCompleteButton() {
        QuizService.shared.createNewQuiz(quizData: quizModel) { data in
            debugPrint(data)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

// MARK: - UITableView
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
            cell.delegate = self
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: answerType[indexPath.row], for: indexPath) as? EssayTableViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
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

// MARK: - Input Delegate
extension CreateAnswerViewController: TrueFalseDelegate {
    func textFieldValueChanged(cell: UITableViewCell, textField: UITextField) {
        guard let index = tableView.indexPath(for: cell)?.row else {
            print("DEBUG - text field indexpath 찾을 수 없음")
            return
        }
        quizModel.quizQuestion[index].type = "t-f"
        quizModel.quizQuestion[index].content = textField.text ?? "textfield 값 없음"
        
    }
    
    func segmentedValueChanged(cell: UITableViewCell, segmented: UISegmentedControl) {
        guard let index = tableView.indexPath(for: cell)?.row else {
            print("DEBUG - segmented indexpath 찾을 수 없음")
            return
        }
        quizModel.quizQuestion[index].answer = segmented.selectedSegmentIndex == 0 ? "true" : "false"
    }
    
}

extension CreateAnswerViewController: EssayDelegate {
    func questionTextFieldValueChanged(cell: UITableViewCell, textField: UITextField) {
        guard let index = tableView.indexPath(for: cell)?.row else {
            print("DEBUG - text field indexpath 찾을 수 없음")
            return
        }
        quizModel.quizQuestion[index].type = "short-answer"
        quizModel.quizQuestion[index].content = textField.text ?? "textfield 값 없음"
    }
    
    func answerTextFieldValueChanged(cell: UITableViewCell, textField: UITextField) {
        guard let index = tableView.indexPath(for: cell)?.row else {
            print("DEBUG - text field indexpath 찾을 수 없음")
            return
        }
        quizModel.quizQuestion[index].answer = textField.text ?? "textfield 값 없음"
    }
    
    
}
