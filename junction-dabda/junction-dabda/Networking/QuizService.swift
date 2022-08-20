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
}
