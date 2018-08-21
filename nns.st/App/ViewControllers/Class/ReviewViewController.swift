//
//  ReviewViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/21.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    
    static func instantiateViewController() -> ReviewViewController {
        let storyboard = UIStoryboard(name: "Review", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! ReviewViewController
        
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


extension ReviewViewController {
    
    @IBAction func didTapView(_ sender: UITapGestureRecognizer) {
        textView.resignFirstResponder()
    }
    
}
