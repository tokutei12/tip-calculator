//
//  SettingsViewController.swift
//  tip_calculator
//
//  Created by Kim Toy (Personal) on 2/18/17.
//  Copyright © 2017 Kim Toy (Personal). All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var tipSettingsPicker: UIPickerView!
    var tipAmt1: String?
    var tipAmt2: String?
    var tipAmt3: String?
    @IBOutlet weak var tipAmount1: UILabel!
    @IBOutlet weak var tipAmount2: UILabel!
    @IBOutlet weak var tipAmount3: UILabel!
    var defaults: UserDefaults?
    
    var currentTipToEdit: Int = 0
    var tipLabels: [UILabel] = [UILabel]()
    
    @IBAction func onTapDefaultTip1(_ sender: Any) {
        currentTipToEdit = 0
        self.tipSettingsPicker.isHidden = false;
    }
    @IBAction func onTapDefaultTip2(_ sender: Any) {
        currentTipToEdit = 1
        self.tipSettingsPicker.isHidden = false;
    }
    @IBAction func onTapDefaultTip3(_ sender: Any) {
        currentTipToEdit = 2
        self.tipSettingsPicker.isHidden = false;
    }
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.defaults = UserDefaults.standard
        self.tipSettingsPicker.isHidden = true;
        self.tipSettingsPicker.delegate = self
        self.tipSettingsPicker.dataSource = self
        pickerData = ["10%", "13%", "15%", "18%", "20%", "23%", "25%", "28%", "30%"]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tipAmount1.text = defaults?.object(forKey: "default_tip_0") as! String? ?? "18%"//tipAmt1
        self.tipAmount2.text = defaults?.object(forKey: "default_tip_1") as! String? ?? "20%"//tipAmt2
        self.tipAmount3.text = defaults?.object(forKey: "default_tip_2") as! String? ?? "25%"//tipAmt3
        tipLabels = [tipAmount1, tipAmount2, tipAmount3]
    }

    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tipLabels[currentTipToEdit].text = pickerData[row]
        self.tipSettingsPicker.isHidden = true;
        defaults?.set(pickerData[row], forKey: "default_tip_\(currentTipToEdit)")
        defaults?.synchronize()
    }
}
