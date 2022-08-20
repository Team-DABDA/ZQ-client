//
//  NewQuizModel.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/21.
//

import Foundation

struct NewQuizModel: Codable {
    var title: String
    var quizScore: Int
    var quizQuestion: [QuizInfoModel]
    
    enum CodingKeys: String, CodingKey {
        case title
        case quizScore = "quiz_score"
        case quizQuestion = "quiz_question"
    }
}

struct QuizInfoModel: Codable {
    var type: String
    var content: String
    var answer: String
}
