//
//  ViewController.swift
//  Tippin
//
//  Created by Waghmare, Amol on 10/03/17.
//  Copyright © 2017 Waghmare, Amol. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = defaults.integerForKey("tip_percentage_index")
        
        billField.becomeFirstResponder()
        
        dispatch_async(dispatch_get_main_queue()) {
            self.billField.text = String(format: "%.2f", defaults.doubleForKey("bill_amount"))
            self.calculateTipInternal()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = defaults.integerForKey("tip_percentage_index");
        calculateTipInternal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(sender: AnyObject) {
        
        let bill = Double(billField.text!) ?? 0
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(bill, forKey: "bill_amount");
        defaults.synchronize();
        
        calculateTipInternal();
    }
    
    func calculateTipInternal() {
        let tipPercentage = [0.15, 0.2, 0.3]
        
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        let total = bill + tip;
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

