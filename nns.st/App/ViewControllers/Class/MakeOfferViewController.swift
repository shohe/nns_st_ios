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
    
    var pickerView: PopupDatePickerView!
    
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
        addPickerView()
        pickerView.initPopupDatePicker()
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
    
    func addPickerView() {
        pickerView = PopupDatePickerView(frame: self.view.bounds)
        pickerView.delegate = self
        self.view.addSubview(pickerView)
    }
    
    func removePickerView() {
        pickerView.hidePopupDatePicker()
    }
    
}


extension MakeOfferViewController: MapViewControllerDelegate {
    
    func mapView(_mapViewController: MapViewController, didSetDistance item: MapViewItem) {
        mapTitle.text = item.title
        mapDistance.text = "\(item.distance)km"
        SnapShotMaker.drawSnapshot(coordinate: item.coordinate, source: snapmap, pinColor: .red)
    }
    
}


extension MakeOfferViewController: PopupDatePickerViewDelegate {
    
    func popupDatePicker(_pickerView: PopupDatePickerView, didCanceled sender: UIButton) {
        removePickerView()
    }
    
    func popupDatePicker(_pickerView: PopupDatePickerView, didSelected sender: UIButton) {
        
    }
    
}
