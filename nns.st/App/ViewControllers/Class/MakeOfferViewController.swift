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
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var veryShort: UIButton!
    @IBOutlet weak var short: UIButton!
    @IBOutlet weak var midium: UIButton!
    @IBOutlet weak var long: UIButton!
    @IBOutlet weak var veryLong: UIButton!
    
    @IBInspectable var selectedColor: UIColor = UIColor.white
    
    var pickerView: PopupDatePickerView!
    var hairTypeItem: [UIButton] = []
    
    static func instantiateViewController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MONavigationController") as! UINavigationController
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transparentNavigationBar()
        self.leftSideCornerRadius(view: snapmap)
        self.setDateTime(date: Date())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hairTypeItem = [veryShort, short, midium, long, veryLong]
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
    
    @IBAction func selectHairType(_ sender: UIButton) {
        for item in hairTypeItem {
            item.backgroundColor = UIColor.white
        }
        sender.backgroundColor = selectedColor
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
    
    func setDateTime(date: Date) {
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy / MM / dd"
        timeFormatter.dateFormat = "HH : mm ~"
        
        self.date.text = dateFormatter.string(from: date)
        self.time.text = timeFormatter.string(from: date)
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
        removePickerView()
        setDateTime(date: pickerView.picker.date)
    }
    
}
