//
//  LoginViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/12.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class LoginViewController: GradationViewController {

    @IBOutlet weak var mailaddress: UnderlineTextField!
    @IBOutlet weak var password: UnderlineTextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var forgetBtn: UIButton!
    @IBOutlet weak var signupBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.localizedText()
        errorMessage.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LoginViewController {
    
    @IBAction func pushNextBtn(_ sender: UIButton) {
        if let email = mailaddress.text, let password = password.text {
            API.loginRequest(email: email, password: password) { (result) in
                if let res = result {
                    let info = NNSCore.userInfo()
                    info.authToken = res.item.token
                    NNSCore.setUserInfo(userInfo: info)
                    self.present(MainViewController.instantiateViewController(), animated: true, completion: nil)
                } else {
                    self.showErrorMessage()
                }
            }
        } else {
            self.showErrorMessage()
        }
    }
    
}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case mailaddress: password.becomeFirstResponder()
            case password: pushNextBtn(loginBtn)
            default: break
        }
        return true
    }
    
}

extension LoginViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension LoginViewController {
    
    private func localizedText() {
        errorMessage.text = NSLocalizedString("loginErrorMessage", comment: "")
        loginBtn.setTitle(NSLocalizedString("login", comment: ""), for: UIControlState.normal)
        forgetBtn.setTitle(NSLocalizedString("forgetPassword", comment: ""), for: UIControlState.normal)
        signupBtn.setTitle(NSLocalizedString("signup", comment: ""), for: UIControlState.normal)
    }
    
    private func showErrorMessage() {
        self.errorMessage.isHidden = false
        self.mailaddress.borderColor = self.errorMessage.textColor
        self.password.borderColor = self.errorMessage.textColor
    }
    
}
