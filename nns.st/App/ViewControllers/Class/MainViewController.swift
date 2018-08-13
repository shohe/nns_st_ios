//
//  MainViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/14.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    static func instantiateViewController() -> MainViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! MainViewController
        
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
