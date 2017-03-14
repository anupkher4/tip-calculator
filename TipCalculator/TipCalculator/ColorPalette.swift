//
//  ColorPalette.swift
//  TipCalculator
//
//  Created by Anup Kher on 3/13/17.
//  Copyright © 2017 anupkher. All rights reserved.
//

import UIKit

enum ColorPalette {
    case wheat, paleGold, darkCoral, isabellineGray, richBlack
    case trolleyGrey, outerSpace, darkJungleGreen
    case yankeesBlue
    case lightGray
    
    func getColor() -> UIColor {
        switch self {
        case .wheat:
            return UIColor(colorLiteralRed:0.96, green:0.89, blue:0.70, alpha:1.0)
        case .paleGold:
            return UIColor(colorLiteralRed:0.94, green:0.78, blue:0.55, alpha:1.0)
        case .darkCoral:
            return UIColor(colorLiteralRed:0.81, green:0.36, blue:0.21, alpha:1.0)
        case .isabellineGray:
            return UIColor(colorLiteralRed: 0.93, green: 0.93, blue: 0.93, alpha: 1.0)
        case .richBlack:
            return UIColor(colorLiteralRed: 0.02, green: 0.02, blue: 0.09, alpha: 1.0)
        case .trolleyGrey:
            return UIColor(colorLiteralRed: 0.498, green: 0.4824, blue: 0.5098, alpha: 1.0)
        case .outerSpace:
            return UIColor(colorLiteralRed: 0.2667, green: 0.2706, blue: 0.3294, alpha: 1.0)
        case .darkJungleGreen:
            return UIColor(colorLiteralRed: 0.0902, green: 0.1294, blue: 0.1294, alpha: 1.0)
        case .yankeesBlue:
            return UIColor(colorLiteralRed: 0.1216, green: 0.1255, blue: 0.2549, alpha: 1.0)
        case .lightGray:
            return UIColor(colorLiteralRed: 0.8431, green: 0.8039, blue: 0.8, alpha: 1.0)
        }
    }
}
