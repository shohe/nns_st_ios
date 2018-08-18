//
//  MapViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/18.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transparentNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addBottomSheetView()
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


extension MapViewController {
    
    func addBottomSheetView() {
        let viewController = BottomSheetViewController.instantiateViewController()
        viewController.view.layer.cornerRadius = 10
        
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        
        viewController.didMove(toParentViewController: self)
        viewController.view.frame.origin = CGPoint(x: 0.0, y: self.view.frame.maxY)
    }
    
}
