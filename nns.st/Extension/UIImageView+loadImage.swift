//
//  UIImageView+loadImage.swift
//  nns.st
//
//  Created by SHOHE on 2018/09/08.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    
//    let CACHE_SEC : TimeInterval = 5 * 60;
    
//    func loadImage(urlString: String){
//        let req = URLRequest(url: NSURL(string:urlString)! as URL,
//                             cachePolicy: .returnCacheDataElseLoad,
//                             timeoutInterval: 5 * 60/*CACHE_SEC*/);
//        let conf =  URLSessionConfiguration.default;
//        let session = URLSession(configuration: conf, delegate: nil, delegateQueue: OperationQueue.main);
//
//        session.dataTask(with: req, completionHandler:
//            { (data, resp, err) in
//                if((err) == nil){ //Success
//                    let image = UIImage(data:data!)
//                    self.image = image;
//
//                }else{ //Error
//                    print("AsyncImageView:Error \(String(describing: err?.localizedDescription))");
//                }
//        }).resume();
//    }
    
    func loadImage(urlString: String) {
        if let url = URL(string: urlString) {
            Nuke.loadImage(with: url,
                           options: ImageLoadingOptions(
                                placeholder: UIImage(named: ""),
                                transition: .fadeIn(duration: 0.33),
                                failureImage: nil,
                                failureImageTransition: .fadeIn(duration: 0.33),
                                contentModes: nil),
                           into: self, progress: nil, completion: nil
            )
        }
    }
    
}
