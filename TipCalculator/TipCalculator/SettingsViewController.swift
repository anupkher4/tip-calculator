//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Anup Kher on 3/7/17.
//  Copyright © 2017 anupkher. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var defaultTipPercentSegment: UISegmentedControl!
    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var themeLabel: UILabel!

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settings"
        
        let defaultTipPc = defaults.integer(forKey: "default_tip_segment")
        defaultTipPercentSegment.selectedSegmentIndex = defaultTipPc
        
        let isLightScheme = defaults.bool(forKey: "color_scheme")
        themeSwitch.setOn(isLightScheme, animated: true)
        
        setThemeLabelWhenSwitch(is: themeSwitch.isOn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tipPercentChanged(_ sender: Any) {
        defaults.set(defaultTipPercentSegment.selectedSegmentIndex, forKey: "default_tip_segment")
        defaults.synchronize()
    }

    @IBAction func themeChanged(_ sender: Any) {
        setThemeLabelWhenSwitch(is: themeSwitch.isOn)
        defaults.set(themeSwitch.isOn, forKey: "color_scheme")
        defaults.synchronize()
    }
    
    func setThemeLabelWhenSwitch(is on: Bool) {
        if on {
            themeLabel.text = "Light"
        } else {
            themeLabel.text = "Dark"
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
