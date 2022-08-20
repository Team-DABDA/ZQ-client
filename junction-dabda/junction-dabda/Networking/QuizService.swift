//
//  QuizService.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/21.
//

import Foundation
import Alamofire

struct QuizService {
    static let shared = QuizService()
    
    private init() { }
}

extension QuizService {
    func getAllQuizs(completion: @escaping (AFDataResponse<Data>) -> Void) {
        let target = APIConstants.baseURL + APIConstants.quiz
        AF.request(target)
            .validate()
            .responseData { response in
                switch response.result {
                case .success:
                    completion(response)
                case .failure:
                    print("FAILURE")
                }
            }
    }
    
    func createNewQuiz(quizData: NewQuizModel,completion: @escaping (AFDataResponse<Data?>) -> Void) {
        guard let token = UserData.shared.token else {
            print("DEBUG: Can't find token")
            return
        }
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        let target = APIConstants.baseURL + APIConstants.quiz
        AF.request(target,
                   method: .post,
                   parameters: quizData,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).response{ response in
            completion(response)
        }
    }
}
