//
//  ViewController.swift
//  TipCalculator
//
//  Created by Anup Kher on 3/3/17.
//  Copyright © 2017 anupkher. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    @IBOutlet weak var totalSubView: UIView!
    @IBOutlet weak var tipPercentSegment: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    let defaults = UserDefaults.standard
    let tipAmounts = [15.0, 18.0, 20.0]
    
    let locale = Locale.current
    let formatter = NumberFormatter()
    let calendar = Calendar.current
    
    var currentString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextField.delegate = self
        
        formatter.locale = locale
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        amountTextField.placeholder = locale.currencySymbol
        
        // Initially hide non-essential elements
        tipPercentSegment.isHidden = true
        totalSubView.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Retrieve last typed amount
        let current = Date()
        
        if let retrieved = defaults.object(forKey: "time_stamp") as? Date {
            if calendar.compare(current, to: retrieved, toGranularity: .day).rawValue == 0 {
                let cComponents = calendar.dateComponents([.hour, .minute], from: current)
                let rComponents = calendar.dateComponents([.hour, .minute], from: retrieved)
                
                if let currentHour = cComponents.hour, let currentMinute = cComponents.minute, let retrievedHour = rComponents.hour, let retrievedMinute = rComponents.minute {
                    
                    if currentHour == retrievedHour {
                        if currentMinute - retrievedMinute < 10 {
                            let amount = defaults.double(forKey: "last_typed_amount")
                            
                            if let text = formatter.string(from: amount as NSNumber) {
                                amountTextField.text = text
                                calculateTotal()
                            }
                            
                        }
                    }
                    
                }
            }
        }
        
        amountTextField.becomeFirstResponder()
        
        let defaultTipPc = defaults.integer(forKey: "default_tip_segment")
        tipPercentSegment.selectedSegmentIndex = defaultTipPc
        
        let isLightScheme = defaults.bool(forKey: "color_scheme")
        
        // Set color scheme
        if isLightScheme {
            navigationController?.navigationBar.barTintColor = ColorPalette.isabellineGray.getColor()
            navigationController?.navigationBar.tintColor = ColorPalette.richBlack.getColor()
            
            view.backgroundColor = ColorPalette.wheat.getColor()
            totalSubView.backgroundColor = ColorPalette.paleGold.getColor()
            tipPercentSegment.tintColor = ColorPalette.darkCoral.getColor()
            
            amountTextField.textColor = ColorPalette.richBlack.getColor()
            tipAmountLabel.textColor = ColorPalette.richBlack.getColor()
            totalLabel.textColor = ColorPalette.richBlack.getColor()
        } else {
            navigationController?.navigationBar.barTintColor = ColorPalette.trolleyGrey.getColor()
            navigationController?.navigationBar.tintColor = ColorPalette.darkJungleGreen.getColor()
            
            view.backgroundColor = ColorPalette.outerSpace.getColor()
            totalSubView.backgroundColor = ColorPalette.yankeesBlue.getColor()
            tipPercentSegment.tintColor = ColorPalette.trolleyGrey.getColor()
            
            amountTextField.textColor = ColorPalette.lightGray.getColor()
            tipAmountLabel.textColor = ColorPalette.lightGray.getColor()
            totalLabel.textColor = ColorPalette.lightGray.getColor()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let timestamp = Date()
        
        guard let text = amountTextField.text else {
            return
        }
        guard let amountNS = formatter.number(from: text) else {
            return
        }
        
        let amount = amountNS as Double
        
        defaults.set(amount as Double, forKey: "last_typed_amount")
        defaults.set(timestamp, forKey: "time_stamp")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func tipPercentChanged(_ sender: Any) {
        calculateTotal()
    }
    
    func calculateTotal() {
        
        guard let text = amountTextField.text else {
            return
        }
        guard let amountNS = formatter.number(from: text) else {
            return
        }
        
        let amount = amountNS as Double
        
        let tipIndex = tipPercentSegment.selectedSegmentIndex
        
        let tipPc = tipAmounts[tipIndex] / 100
        let tip = amount * tipPc
        let total = amount + tip
        
        updateLabels(tip: tip, total: total)
        
    }
    
    func updateLabels(tip: Double, total: Double) {
        
        // Show hidden elements after begin typing
        tipPercentSegment.isHidden = false
        totalSubView.isHidden = false
        
        guard let fTip = formatter.string(from: tip as NSNumber) else {
            return
        }
        guard let fTotal = formatter.string(from: total as NSNumber) else {
            return
        }
        
        tipAmountLabel.text = fTip
        totalLabel.text = fTotal
        
    }
    
    func formatCurrency(string: String) {
        
        guard let number = Double(string) else {
            return
        }
        
        let value = number / 100
        
        amountTextField.text = formatter.string(from: value as NSNumber)
        
        calculateTotal()
        
    }
    
}

extension TipViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Show hidden elements after begin typing
        tipPercentSegment.isHidden = false
        totalSubView.isHidden = false
        
        switch string {
        case "0","1","2","3","4","5","6","7","8","9":
            currentString += string
            formatCurrency(string: currentString)
        default:
            if string.characters.count == 0 && currentString.characters.count != 0 {
                currentString = String(currentString.characters.dropLast())
                formatCurrency(string: currentString)
            }
        }
        
        return false
    }
    
}
