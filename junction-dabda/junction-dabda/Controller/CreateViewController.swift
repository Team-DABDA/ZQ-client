//
//  CreateViewController.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/20.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var scoreTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        self.navigationItem.title = "새 문제 만들기"
        navigationItem.backButtonTitle = ""
    }
    
    @IBAction func pressedNextButton() {
        guard let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateAnswerViewController") as? CreateAnswerViewController else { return }
        nextViewController.quizModel.title = titleTextfield.text ?? ""
        nextViewController.quizModel.quizScore = Int(scoreTextfield.text ?? "0") ?? 0
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

}
