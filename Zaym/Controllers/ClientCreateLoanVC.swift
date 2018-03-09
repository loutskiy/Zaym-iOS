//
//  ClientCreateLoanVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit

class ClientCreateLoanVC: UITableViewController {

    @IBOutlet weak var sumStepper: UIStepper!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var sumToReturnLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func datePickerChange(_ sender: UIDatePicker) {
        generateSumToReturn()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = Date().addingTimeInterval(60*60*24)
        datePicker.date = Date().addingTimeInterval(60*60*24)
        datePicker.maximumDate = Date().addingTimeInterval(60*60*24*30)
        generateSumToReturn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func orderAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let loan = Loan()
        loan.client_id = UserCache.userId()
        loan.sum = Float(sumStepper.value)
        loan.sum_to_return = Float(((((datePicker.date.timeIntervalSince1970 - Date().timeIntervalSince1970) / (60*60*24) / 10) + 1) * sumStepper.value * 1.05))
        loan.date_issue = dateFormatter.string(from: Date())
        loan.date_exp = dateFormatter.string(from: datePicker.date)
        loan.create()
    }
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        sumLabel.text = "\(String(format: "%.2f", sender.value))₽"
        generateSumToReturn()
    }
    
    func generateSumToReturn () {
        var sum = sumStepper.value * 1.05
        let date = ((datePicker.date.timeIntervalSince1970 - Date().timeIntervalSince1970) / (60*60*24) / 10) + 1
        print(date)
        sum *= date
        sumToReturnLabel.text = "\(String(format: "%.2f", sum))₽"
    }
}
