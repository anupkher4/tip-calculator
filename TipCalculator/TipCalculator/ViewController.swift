//
//  ViewController.swift
//  TipCalculator
//
//  Created by Anup Kher on 3/3/17.
//  Copyright © 2017 anupkher. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
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
        tipAmountLabel.isHidden = true
        totalLabel.isHidden = true
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
        tipAmountLabel.isHidden = false
        totalLabel.isHidden = false
        
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

