//
//  ViewController.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/20.
//

import UIKit

private let cellIdentifier = "MainCell"

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var quizList: [QuizModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        loadQuizData()
    }

    @IBAction func pressedCreateButton() {
        guard let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateViewController") as? CreateViewController else { return }
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func configureNavigationBar() {
        let logoImageView = UIImageView(image: UIImage(named: "simpleLogo") ?? UIImage())
        logoImageView.contentMode = .scaleAspectFit

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 60),
            logoImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
                
        self.navigationItem.titleView = logoImageView
        
        navigationItem.backButtonTitle = ""
    }
    
    func loadQuizData() {
        QuizService.shared.getAllQuizs { data in
            guard let data = data.value else {
                print("DEBUG - Fail to load data")
                return
            }
            guard let quizData = try? JSONDecoder().decode([QuizModel].self, from: data) else {
                print("DEBUG - Fail to decode")
                return
            }
            self.quizList = quizData
        }
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let quiz = quizList[indexPath.row]
        cell.profileImageView.image = ProfileImageList.imageList[Int.random(in: 0...8)]
        cell.titleLabel.text = quiz.title
        cell.questionId.text = "#\(quiz.id)"
        cell.writerLabel.text = String(quiz.user) + "번님의 문제"
        cell.scoreLabel.text = "\(quiz.quizScore)점"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

