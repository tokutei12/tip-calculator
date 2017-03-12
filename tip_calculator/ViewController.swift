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
    @IBOutlet weak var tipView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        billField.becomeFirstResponder()
        tipView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let defaults = UserDefaults.standard
        self.tipControl.setTitle(defaults.object(forKey: "default_tip_0") as! String? ?? "18%", forSegmentAt: 0)
        self.tipControl.setTitle(defaults.object(forKey: "default_tip_1") as! String? ?? "20%", forSegmentAt: 1)
        self.tipControl.setTitle(defaults.object(forKey: "default_tip_2") as! String? ?? "25%", forSegmentAt: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(_ sender: AnyObject) {
        if (self.tipView.alpha != 1) {
            UIView.animate(withDuration: 0.4, animations: {
                self.tipView.alpha = 1
            })
        }
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

