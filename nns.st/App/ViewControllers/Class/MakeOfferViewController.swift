//
//  MakeOfferViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/16.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MakeOfferViewController: UIViewController {
    
    @IBOutlet weak var snapmap: UIImageView!
    @IBOutlet weak var mapTitle: UILabel!
    @IBOutlet weak var mapDistance: UILabel!
    
    static func instantiateViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MONavigationController") as! UINavigationController
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transparentNavigationBar()
        self.leftSideCornerRadius(view: snapmap)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}



extension MakeOfferViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapDateTimeField(_ sender: UITapGestureRecognizer) {
        print("tap date/time")
    }
    
    @IBAction func tapMapField(_ sender: UITapGestureRecognizer) {
        let viewController = MapViewController.instantiateViewController()
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func leftSideCornerRadius(view: UIImageView) -> Void {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: 5, height: 5))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
}


extension MakeOfferViewController: MapViewControllerDelegate {
    
    func mapView(_mapViewController: MapViewController, didSetDistance item: MapViewItem) {
        mapTitle.text = item.title
        mapDistance.text = "\(item.distance)km"
    }
    
}
