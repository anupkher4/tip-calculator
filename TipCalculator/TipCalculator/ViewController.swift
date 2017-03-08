//
//  ViewController.swift
//  TipCalculator
//
//  Created by Anup Kher on 3/3/17.
//  Copyright © 2017 anupkher. All rights reserved.
//

import UIKit

enum ColorPalette {
    case wheat, paleGold, darkCoral, isabellineGray, richBlack
    
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
        }
    }
}

class TipViewController: UIViewController {
    @IBOutlet weak var totalSubView: UIView!
    @IBOutlet weak var tipPercentSegment: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    let defaults = UserDefaults.standard
    let tipAmounts = [15.0, 18.0, 20.0]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultTipPc = defaults.integer(forKey: "default_tip_segment")
        tipPercentSegment.selectedSegmentIndex = defaultTipPc
        
        // Initially hide non-essential elements
        tipPercentSegment.isHidden = true
        totalSubView.isHidden = true
        
        navigationController?.navigationBar.barTintColor = ColorPalette.isabellineGray.getColor()
        navigationController?.navigationBar.tintColor = ColorPalette.richBlack.getColor()
        view.backgroundColor = ColorPalette.wheat.getColor()
        totalSubView.backgroundColor = ColorPalette.paleGold.getColor()
        tipPercentSegment.tintColor = ColorPalette.darkCoral.getColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        amountTextField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func tipPercentChanged(_ sender: Any) {
        amountChanged(sender)
    }

    @IBAction func amountChanged(_ sender: Any) {
        
        // Show hidden elements after begin typing
        tipPercentSegment.isHidden = false
        totalSubView.isHidden = false
        
        guard let text = amountTextField.text else {
            return
        }
        guard let amount = Double(text) else {
            return
        }
        let tipPc = tipAmounts[tipPercentSegment.selectedSegmentIndex] / 100
        let tip = amount * tipPc
        tipAmountLabel.text = "+ $\(String(format: "%.2f", tip))"
        let total = amount + tip
        totalLabel.text = "= $\(String(format: "%.2f", total))"
    }

}

