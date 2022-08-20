//
//  LoginViewController.swift
//  junction-dabda
//
//  Created by 이서영 on 2022/08/20.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
    }
    
    @IBAction func pressedLoginButton() {
        print("DEBUG - Log in")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainNavigationController = storyboard.instantiateViewController(identifier: "MainNavigationController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(mainNavigationController)
    }
    
    @IBAction func pressedSignUpButton() {
        guard let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        navigationController?.pushViewController(nextViewController, animated: true)
    }

}
