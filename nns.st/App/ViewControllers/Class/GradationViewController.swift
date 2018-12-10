//
//  ViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/02.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import APIKit

class GradationViewController: NNSViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let view = self.view as! BackgroundView
        view.setGradation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension GradationViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
