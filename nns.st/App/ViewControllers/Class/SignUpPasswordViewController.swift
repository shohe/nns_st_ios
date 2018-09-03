//
//  SignUpPasswordViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/13.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class SignUpPasswordViewController: UIViewController {
    
    @IBOutlet weak var password: ContainButtonTextField!
    @IBOutlet weak var passwordConfirm: ContainButtonTextField!
    
    private var mailaddress: String?
    
    
    static func instantiateViewController(mailaddress: String) -> SignUpPasswordViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignUpPasswordViewController") as! SignUpPasswordViewController
        viewController.mailaddress = mailaddress
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
