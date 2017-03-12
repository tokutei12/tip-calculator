//
//  ViewController.swift
//  tip_calculator
//
//  Created by Kim Toy (Personal) on 2/11/17.
//  Copyright © 2017 Kim Toy (Personal). All rights reserved.
//
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(forName:Notification.Name(rawValue:"TipChanged"),
                                               object:nil, queue:nil,
                                               using:catchNotification)
        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func catchNotification(notification:Notification) -> Void {
        guard let userInfo = notification.userInfo,
            let tipIndex = userInfo["tipIndex"] as? Int,
            let tipAmount = userInfo["tipAmount"] as? String else {
                print("No userInfo found in notification")
                return
            }
        self.tipControl.setTitle(tipAmount, forSegmentAt: tipIndex)
        self.calculateTip(self.tipControl)
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.tipAmt1 = tipControl.titleForSegment(at: 0) as String!
        settingsViewController.tipAmt2 = tipControl.titleForSegment(at: 1) as String!
        settingsViewController.tipAmt3 = tipControl.titleForSegment(at: 2) as String!
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        var tipPercentStr = tipControl.titleForSegment(at: tipControl.selectedSegmentIndex)
        tipPercentStr!.remove(at: tipPercentStr!.index(before: tipPercentStr!.endIndex))
        let tipPercentDouble = (Double(tipPercentStr!) ?? 0)/100.0
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentDouble
        let total = bill + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

