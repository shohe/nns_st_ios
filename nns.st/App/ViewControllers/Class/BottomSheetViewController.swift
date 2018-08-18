//
//  BottomSheetViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/18.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    

    static func instantiateViewController() -> BottomSheetViewController {
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "BottomSheetViewController") as! BottomSheetViewController
        
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.prepareBackgroundView()
        // self.changeSearchBarColor(color: .white)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3) {
            let frame = self.view.frame
            let componentY = UIScreen.main.bounds.height - 200
            self.view.frame = CGRect(x: 0, y: componentY, width: frame.width, height: frame.height)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension BottomSheetViewController {
    
    func prepareBackgroundView() {
        let blurEffect = UIBlurEffect.init(style: .extraLight)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.alpha = 0.8
        bluredView.contentView.addSubview(visualEffect)
        
        let radius = view.layer.cornerRadius
        visualEffect.frame = UIScreen.main.bounds
        visualEffect.contentView.layer.cornerRadius = radius
        bluredView.frame = UIScreen.main.bounds
        bluredView.contentView.layer.cornerRadius = radius

        view.insertSubview(bluredView, at: 0)
    }
    
    func changeSearchBarColor(color: UIColor) {
        UIGraphicsBeginImageContext(searchBar.frame.size)
        color.setFill()
        UIBezierPath(rect: searchBar.frame).fill()
        let bgImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        searchBar.setSearchFieldBackgroundImage(bgImage, for: .normal)
    }
    
}
