//
//  SignUpNameViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/13.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class SignUpNameViewController: UIViewController {

    
    @IBOutlet weak var lastName: ContainButtonTextField!
    @IBOutlet weak var firstName: ContainButtonTextField!
    
    private var mailaddress: String?
    private var password: String?
    
    
    static func instantiateViewController(mailaddress: String, password: String) -> SignUpNameViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignUpNameViewController") as! SignUpNameViewController
        viewController.mailaddress = mailaddress
        viewController.password = password
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SignUpNameViewController {
    
    @IBAction func pushNextBtn(_ sender: UIButton) {
        self.present(MainViewController.instantiateViewController(), animated: true, completion: nil)
    }
    
}
