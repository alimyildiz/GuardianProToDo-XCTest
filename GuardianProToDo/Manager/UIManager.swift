//
//  UIManager.swift
//  MeditopiaTask
//
//  Created by Alim Yıldız on 3/27/21.
//  Copyright © 2021 Alim Yıldız. All rights reserved.
//

import UIKit

class UIManager: NSObject {
    public static let instance:UIManager = UIManager()
    var gl:CAGradientLayer = CAGradientLayer()

    
    func colors(viewBound:CGRect) -> CAGradientLayer {

        let colorTop = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 60, green: 77, blue: 135, alpha: 1.0).cgColor

        gl.colors = [colorBottom, colorTop]
        gl.startPoint = CGPoint(x: 0.5, y: 1.0)
        gl.endPoint = CGPoint(x: 0.5, y: 0.0)
        gl.locations = [0, 1]
        gl.frame = viewBound
        
        return self.gl
    }
}

