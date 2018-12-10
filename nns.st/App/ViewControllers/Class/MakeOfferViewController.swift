//
//  MakeOfferViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/16.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class MakeOfferViewController: GradationViewController {
    
    @IBOutlet weak var offerMenu: UITextField!
    @IBOutlet weak var offerPrice: UITextField! {
        didSet {
            offerPrice?.addDoneToolbar(onDone: (target: self, action: #selector(donePrice)))
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var snapmap: UIImageView!
    @IBOutlet weak var mapTitle: UILabel!
    @IBOutlet weak var mapDistance: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var offerButton: UIButton!
    
    // ↓ hair button
    @IBOutlet weak var veryShort: UIButton!
    @IBOutlet weak var short: UIButton!
    @IBOutlet weak var midium: UIButton!
    @IBOutlet weak var long: UIButton!
    @IBOutlet weak var veryLong: UIButton!
    
    // ↓ hair label
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var mediumLongLabel: UILabel!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var mediumShortLabel: UILabel!
    @IBOutlet weak var shortLabel: UILabel!
    
    @IBOutlet weak var currentLengthLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var withinLabel: UILabel!
    @IBOutlet weak var distanceLabelCenter: NSLayoutConstraint!
    
    
    @IBInspectable var selectedColor: UIColor = UIColor.white
    
    private var pickerView: PopupDatePickerView!
    private var hairTypeItem: [UIButton] = []
    private var offerItem: OfferItem = OfferItem()
    private var isNominated: Bool = false
    
    private var parentVC: MainViewController?
    private var nominateStylist: User?
    
    static func instantiateViewController(parent: MainViewController) -> UINavigationController {
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
        let root = viewController.viewControllers.first as! MakeOfferViewController
        root.parentVC = parent
        return viewController
    }
    
    static func instantiateViewController(stylist: User, parent: MainViewController) -> UINavigationController {
        let storyboard = UIStoryboard(name: "Offer", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! UINavigationController
        let root = viewController.viewControllers.first as! MakeOfferViewController
        root.isNominated = true
        root.nominateStylist = stylist
        root.offerItem.stylistId = stylist.id
        root.parentVC = parent
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transparentNavigationBar()
        self.leftSideCornerRadius(view: snapmap)
        self.nominateStylistFormat(isTransform: isNominated)
        
        navigationItem.title = NSLocalizedString("offerTitle", comment: "")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDateTime(date: Date())
        hairTypeItem = [veryShort, short, midium, long, veryLong]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func localizedText() {
        offerMenu.placeholder = NSLocalizedString("placeholderMenu", comment: "")
        offerPrice.placeholder = NSLocalizedString("placeholderOfferPrice", comment: "")
        dateLabel.text = NSLocalizedString("date", comment: "")
        timeLabel.text = NSLocalizedString("time", comment: "")
        fromLabel.text = NSLocalizedString("from", comment: "")
        withinLabel.text = NSLocalizedString("within", comment: "")
        mapTitle.text = NSLocalizedString("unspecified", comment: "")
        currentLengthLabel.text = NSLocalizedString("currentLength", comment: "")
        offerButton.setTitle(NSLocalizedString("confirmOffer", comment: ""), for: .normal)
        longLabel.text = NSLocalizedString("longHairLabel", comment: "")
        mediumLongLabel.text = NSLocalizedString("mediumLongHairLabel", comment: "")
        mediumLabel.text = NSLocalizedString("mediumHairLabel", comment: "")
        mediumShortLabel.text = NSLocalizedString("mediumShortHairLabel", comment: "")
        shortLabel.text = NSLocalizedString("shortHairLabel", comment: "")
    }
    
}


// MARK: - IBAction
extension MakeOfferViewController {
    
    @IBAction func backPreView(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapDateTimeField(_ sender: UITapGestureRecognizer) {
        offerMenu.resignFirstResponder()
        offerPrice.resignFirstResponder()
        
        addPickerView()
        pickerView.initPopupDatePicker()
    }
    
    @IBAction func tapMapField(_ sender: UITapGestureRecognizer) {
        offerMenu.resignFirstResponder()
        
        if isNominated {
            if let stylist = self.nominateStylist {
                if let id = stylist.id, let name = stylist.name {
                    self.present(ProfileViewController.instantiateViewController(id: id, name: name), animated: true, completion: nil)
                }
            }
        } else {
            let viewController = MapViewController.instantiateViewController()
            viewController.delegate = self
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func selectHairType(_ sender: UIButton) {
        for item in hairTypeItem {
            item.backgroundColor = UIColor.white
        }
        sender.backgroundColor = selectedColor
        
        offerItem.hairType = HairType(rawValue: sender.tag)
        setEnableButton(offer: offerItem)
    }
    
    @IBAction func confirmOffer(_ sender: UIButton) {
        if isNominated {
            if let stylist = self.nominateStylist {
                let viewController = ConfirmOfferViewController.instantiateViewController(parent: self.parentVC!, stylist: stylist)
                viewController.offerItem = self.offerItem
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        } else {
            let viewController = ConfirmOfferViewController.instantiateViewController(parent: self.parentVC!)
            viewController.offerItem = self.offerItem
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}


// MARK: - private function
extension MakeOfferViewController {
    
     private func leftSideCornerRadius(view: UIImageView) -> Void {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: 5, height: 5))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    private func addPickerView() {
        pickerView = PopupDatePickerView(frame: self.view.bounds)
        pickerView.delegate = self
        self.view.addSubview(pickerView)
    }
    
    private func removePickerView() {
        pickerView.hidePopupDatePicker()
    }
    
    private func setDateTime(date: Date) {
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy / MM / dd"
        timeFormatter.dateFormat = "HH : mm ~"
        
        self.date.text = dateFormatter.string(from: date)
        self.time.text = timeFormatter.string(from: date)
        
        offerItem.datetime = date
    }
    
    private func textToPrice(text: String?) -> String {
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
    
    private func priceToNumber(text: String?) -> String? {
        if var price = (text as NSString?) {
            price = price.replacingOccurrences(of: "¥", with: "") as NSString
            price = price.replacingOccurrences(of: ",", with: "") as NSString
            if price != "0" {
                return String(price)
            }
        }
        return nil
    }
    
    private func setEnableButton(offer: OfferItem) {
        UIView.animate(withDuration: 0.3, animations: {
            self.offerButton.alpha = (offer.checkAllValue()) ? 1 : 0.3
        }) { (complete) in
            self.offerButton.isEnabled = offer.checkAllValue()
        }
    }
    
    private func nominateStylistFormat(isTransform: Bool) {
        if isNominated, let stylist = self.nominateStylist {
            self.hideDistanceInfo()
            mapTitle.text = stylist.salonName
            mapTitle.adjustsFontSizeToFitWidth = true
            mapDistance.text = stylist.name
            if let url = stylist.imageUrl { snapmap.loadImage(urlString: url) }
        }
    }
    
    private func hideDistanceInfo() {
        fromLabel.frame = CGRect.zero
        fromLabel.isHidden = true
        withinLabel.frame = CGRect.zero
        withinLabel.isHidden = true
        
        mapTitle.font = mapTitle.font.withSize(14)
        mapDistance.font = mapDistance.font.withSize(22)
        distanceLabelCenter.constant = -18.0
    }
    
}


// MARK: - MapViewControllerDelegate
extension MakeOfferViewController: MapViewControllerDelegate {
    
    func mapView(_mapViewController: MapViewController, didSetDistance item: MapViewItem) {
        mapTitle.text = item.title
        mapDistance.text = "\(item.distance)km"
        SnapShotMaker.drawSnapshot(coordinate: item.coordinate, source: snapmap, pinColor: .red)
        
        offerItem.location = item.coordinate
        offerItem.distance = item.distance
        offerItem.place = item.title
        setEnableButton(offer: offerItem)
    }
    
}


// MARK: - PopupDatePickerViewDelegate
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


// MARK: - UITextFieldDelegate
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
        if let price = (offerPrice.text as NSString?)?.floatValue {
            offerItem.price = CGFloat(price)
        }
        offerPrice.text = textToPrice(text: offerPrice.text)
        setEnableButton(offer: offerItem)
    }
    
}
