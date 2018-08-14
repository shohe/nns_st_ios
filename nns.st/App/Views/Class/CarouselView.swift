//
//  CarouselView.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/14.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit

class CarouselView: UICollectionView {
    
    func transformScale(cell: UICollectionViewCell) {
        let cellCenter:CGPoint = self.convert(cell.center, to: nil)
        let screenCenterX:CGFloat = UIScreen.main.bounds.width / 2
        let reductionRatio:CGFloat = -0.0009
        let maxScale:CGFloat = 1
        let cellCenterDisX:CGFloat = screenCenterX - cellCenter.x
        let newScale = reductionRatio * cellCenterDisX + maxScale
        cell.transform = CGAffineTransform(scaleX:newScale, y:newScale)
    }
    
}
