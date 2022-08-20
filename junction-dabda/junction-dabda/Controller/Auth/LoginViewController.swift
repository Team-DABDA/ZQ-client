//
//  LoginViewController.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/20.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        loginButton.layer.cornerRadius = 15
    }
    
    @IBAction func pressedLoginButton() {
        guard let userId = idTextField.text, let password = passwordTextField.text else {
            return
        }
        let login = LoginModel(nickname: userId, password: password)
        
        AuthService.shared.login(userInfo: login) { response in
            guard let response = response.value else { return }
            guard let data = response else { return }
            guard let responseData = try? JSONDecoder().decode(LoginUserInfoModel.self, from: data) else { return }
            UserData.shared.nickname = responseData.nickname
            UserData.shared.token = responseData.token.access
            
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainNavigationController = storyboard.instantiateViewController(identifier: "MainNavigationController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(mainNavigationController)

    }
    
    @IBAction func pressedSignUpButton() {
        guard let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        navigationController?.pushViewController(nextViewController, animated: true)
    }

}
