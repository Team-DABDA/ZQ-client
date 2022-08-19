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
        self.navigationItem.title = "앱 이름"
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

