//
//  MyReviewViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/30.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MyReviewViewController: UIViewController {
    
    
    static func instantiateViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Review", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MRNavigationController") as! UINavigationController
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


// MARK: - IBAction
extension MyReviewViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
