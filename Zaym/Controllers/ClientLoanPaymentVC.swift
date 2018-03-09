//
//  ClientLoanPaymentVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit

class ClientLoanPaymentVC: UIViewController {
    var sum = 0.0
    var loan: Loan?
    
    @IBOutlet weak var sumStepper: UIStepper!
    @IBOutlet weak var sumLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        sumStepper.maximumValue = sum
        sumLabel.text = "Сумма: 0₽"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func paymentAction(_ sender: Any) {
        if sumStepper.value != 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let transaction = LoanTransaction()
            transaction.loan_id = loan?.id
            transaction.is_inside = true
            transaction.sum = Float(sumStepper.value)
            transaction.date = dateFormatter.string(from: Date())
            loan?.loan_transactions?.insert(transaction, at: 0)
            transaction.add()
        } else {
            showAlertMessage(text: "Заполните сумму погашения", title: "Ошибка")
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
