//
//  MakeOfferViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/16.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MakeOfferViewController: UIViewController {
    
    @IBOutlet weak var offerMenu: UITextField!
    @IBOutlet weak var offerPrice: UITextField! {
        didSet {
            offerPrice?.addDoneToolbar(onDone: (target: self, action: #selector(donePrice)))
        }
    }
    
    @IBOutlet weak var snapmap: UIImageView!
    @IBOutlet weak var mapTitle: UILabel!
    @IBOutlet weak var mapDistance: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var offerButton: UIButton!
    
    @IBOutlet weak var veryShort: UIButton!
    @IBOutlet weak var short: UIButton!
    @IBOutlet weak var midium: UIButton!
    @IBOutlet weak var long: UIButton!
    @IBOutlet weak var veryLong: UIButton!
    
    @IBInspectable var selectedColor: UIColor = UIColor.white
    
    private var pickerView: PopupDatePickerView!
    private var hairTypeItem: [UIButton] = []
    private var offerItem: OfferItem = OfferItem()
    
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
        
        offerItem.hairType = HairType(rawValue: sender.tag)
        setEnableButton(offer: offerItem)
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
        
        offerItem.datetime = date
    }
    
    func textToPrice(text: String?) -> String {
        if let price = (text as NSString?)?.floatValue {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedPrice = numberFormatter.string(from: NSNumber(value: price))
            if let price = formattedPrice {
                return "¥\(price)"
            }
        }
        return ""
    }
    
    func priceToNumber(text: String?) -> String? {
        if var price = (text as NSString?) {
            price = price.replacingOccurrences(of: "¥", with: "") as NSString
            price = price.replacingOccurrences(of: ",", with: "") as NSString
            if price != "0" {
                return String(price)
            }
        }
        return nil
    }
    
    func setEnableButton(offer: OfferItem) {
        UIView.animate(withDuration: 0.3, animations: {
            self.offerButton.alpha = (offer.checkAllValue()) ? 1 : 0.3
        }) { (complete) in
            self.offerButton.isEnabled = offer.checkAllValue()
        }
    }
    
    @IBAction func confirmOffer(_ sender: UIButton) {
        let viewController = ConfirmOfferViewController.instantiateViewController()
        viewController.offerItem = offerItem
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}


extension MakeOfferViewController: MapViewControllerDelegate {
    
    func mapView(_mapViewController: MapViewController, didSetDistance item: MapViewItem) {
        mapTitle.text = item.title
        mapDistance.text = "\(item.distance)km"
        SnapShotMaker.drawSnapshot(coordinate: item.coordinate, source: snapmap, pinColor: .red)
        
        offerItem.location = item.coordinate
        offerItem.distance = item.distance
        setEnableButton(offer: offerItem)
    }
    
}


extension MakeOfferViewController: PopupDatePickerViewDelegate {
    
    func popupDatePicker(_pickerView: PopupDatePickerView, didCanceled sender: UIButton) {
        removePickerView()
    }
    
    func popupDatePicker(_pickerView: PopupDatePickerView, didSelected sender: UIButton) {
        removePickerView()
        setDateTime(date: pickerView.picker.date)
        setEnableButton(offer: offerItem)
    }
    
}


extension MakeOfferViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 1 /* offerPrice */ {
            textField.text = priceToNumber(text: textField.text)
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 0 /* offerMenu */ {
            if let menu = textField.text {
                offerItem.menu = menu
            }
        }
        setEnableButton(offer: offerItem)
    }
    
    @objc func donePrice() {
        offerPrice.resignFirstResponder()
        offerPrice.text = textToPrice(text: offerPrice.text)
        if let price = (offerPrice.text as NSString?)?.floatValue {
            offerItem.price = CGFloat(price)
        }
        setEnableButton(offer: offerItem)
    }
    
}
