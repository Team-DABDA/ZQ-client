//
//  UserInfoModel.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/21.
//

import Foundation

struct LoginModel: Codable {
    var nickname: String
    var password: String
}

class UserData {
    static let shared = UserData()
    var nickname: String?
    var password: String?
    var token: String?
    private init() { }
}


struct LoginUserInfoModel: Codable {
    var nickname: String
    var message: String
    var token: TokenModel
}

struct TokenModel: Codable {
    var access: String
    var refresh: String
}
