//
//  UserAddLoanStatusVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 12.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit

class UserAddLoanStatusVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return LoanStatuses.all.count
    }
    
    var loan: Loan?
    
    @IBOutlet weak var statusPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusPicker.delegate = self
        statusPicker.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBAction func saveAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let history = LoanHistory()
        history.loan_id = loan?.id
        history.user_id = UserCache.userId()
        history.status = statusPicker.selectedRow(inComponent: 0)
        history.date = dateFormatter.string(from: Date())
        history.add()
        loan?.loan_history?.insert(history, at: 0)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return LoanStatuses.all[row]
    }
    
}
