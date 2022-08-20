//
//  ViewController.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/20.
//

import UIKit

private let cellIdentifier = "MainCell"

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureNavigationBar()
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

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.profileImageView.image = ProfileImageList.imageList[Int.random(in: 0...8)]
        cell.titleLabel.text = "문제 제목"
        cell.questionId.text = "#1"
        cell.writerLabel.text = "닉네임"
        cell.scoreLabel.text = "5점"
        return cell
    }
}

