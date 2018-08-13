//
//  SignUpMailViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/12.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class SignUpMailViewController: UIViewController {
    
    @IBOutlet weak var mailaddress: ContainButtonTextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transparentNavigationBar()
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


// MARK: - Navigation
extension SignUpMailViewController {
    
    @IBAction func cancelSignUp(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
