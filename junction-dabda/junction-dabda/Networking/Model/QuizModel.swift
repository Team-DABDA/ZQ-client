//
//  QuizModel.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/21.
//

import Foundation

struct QuizListModel: Codable {
    var quizList: [QuizModel]
}

struct QuizModel: Codable {
    var id: Int
    var user: Int
    var title: String
    var quizScore: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case user
        case title
        case quizScore = "quiz_score"
    }
}
