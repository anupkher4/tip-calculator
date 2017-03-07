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
    @IBOutlet weak var splitForTwoLabel: UILabel!
    @IBOutlet weak var splitForFourLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    
    let tipAmounts = [15.0, 18.0, 20.0]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tipPercentChanged(_ sender: Any) {
        amountChanged(sender)
    }

    @IBAction func amountChanged(_ sender: Any) {
        guard let text = amountTextField.text else {
            return
        }
        guard let amount = Double(text) else {
            return
        }
        let tip = tipAmounts[tipPercentSegment.selectedSegmentIndex] / 100
        let total = amount + (amount * tip)
        totalLabel.text = "= \(String(format: "%.2f", total))"
        splitForTwoLabel.text = "Split for 2: \(String(format: "%.2f", total / 2))"
        splitForFourLabel.text = "Split for 4: \(String(format: "%.2f", total / 4))"
    }

}

