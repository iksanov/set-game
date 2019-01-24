//
//  SetCardView.swift
//  SetGame
//
//  Created by MacBookPro on 24/01/2019.
//  Copyright © 2019 Iksanov. All rights reserved.
//

import UIKit

class SetCardView: UIView {


    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
//        roundedRect.addClip()
        #colorLiteral(red: 0.9764705882, green: 0.8392156863, blue: 0.6862745098, alpha: 1).setFill()
        roundedRect.fill()
    }

}

extension SetCardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
    }
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
}
