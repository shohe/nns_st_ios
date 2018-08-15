//
//  ConfirmRequestViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/15.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class ConfirmRequestViewController: UIViewController {
    
    static func instantiateViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Confirm", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CRNavigationController") as! UINavigationController
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}


// MARK: - Navigation
extension ConfirmRequestViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
