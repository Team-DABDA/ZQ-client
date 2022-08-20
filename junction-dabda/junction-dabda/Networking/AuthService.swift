//
//  AuthService.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/21.
//

import Foundation
import Alamofire

struct AuthService {
    static let shared = AuthService()
    
    private init() { }
}

extension AuthService {
    func login(userInfo: LoginModel, completion: @escaping(AFDataResponse<Data?>) -> Void) {
        AF.request(APIConstants.baseURL + APIConstants.login,
                   method: .post,
                   parameters: userInfo,
                   encoder: JSONParameterEncoder.default).response{ response in
            completion(response)
        }
    }
}
