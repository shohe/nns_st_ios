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
    @IBOutlet weak var star01: UIButton!
    @IBOutlet weak var star02: UIButton!
    @IBOutlet weak var star03: UIButton!
    @IBOutlet weak var star04: UIButton!
    @IBOutlet weak var star05: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    private var stars: [UIButton] = []
    
    static func instantiateViewController() -> ReviewViewController {
        let storyboard = UIStoryboard(name: "Review", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! ReviewViewController
        
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stars = [star01, star02, star03, star04, star05]
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
    
    @IBAction func didTapStar(_ sender: UIButton) {
        updateSendButton(isEnable: true)
        evaluateStar(sender: sender)
    }
    
    @IBAction func sendReview(_ sender: UIButton) {
        
    }
    
    private func evaluateStar(sender: UIButton) {
        for star in stars {
            star.backgroundColor = .white
        }
        for evaluate in 1...sender.tag {
            stars[evaluate - 1].backgroundColor = .yellow
        }
    }
    
    func updateSendButton(isEnable: Bool) {
        sendButton.isEnabled = isEnable
        sendButton.alpha = (isEnable) ? 1 : 0.3
    }
    
}
