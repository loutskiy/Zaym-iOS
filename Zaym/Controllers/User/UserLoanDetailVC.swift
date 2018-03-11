//
//  UserLoanDetailVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 10.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit

class UserLoanDetailVC: UITableViewController {
    @IBOutlet weak var typeTable: UISegmentedControl!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateExpLabel: UILabel!
    @IBOutlet weak var dateIssueLabel: UILabel!
    @IBOutlet weak var sumBackLabel: UILabel!
    @IBOutlet weak var sumToReturnLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var fioLabel: UILabel!
    @IBOutlet weak var fraudLabel: UILabel!
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var passNumLabel: UILabel!
    @IBOutlet weak var passCountryLabel: UILabel!
    @IBOutlet weak var dateIssuePassport: UILabel!
    @IBOutlet weak var dateExpPassport: UILabel!
    
    var loan: Loan?
    var sumReturned = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        let addStatus = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAddStatusVC))
        navigationItem.rightBarButtonItem = addStatus
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func openAddStatusVC () {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserAddLoanStatusVC") as! UserAddLoanStatusVC
        vc.loan = loan
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        sumLabel.text = "\(String(format: "%.2f", (loan?.sum)!))₽"
        sumToReturnLabel.text = "\(String(format: "%.2f", (loan?.sum_to_return)!))₽"
        sumReturned = 0.0
        for transaction in (loan?.loan_transactions)! {
            if transaction.is_inside! {
                sumReturned += Double(transaction.sum!)
            }
        }
        sumBackLabel.text = "\(String(format: "%.2f", (sumReturned)))₽"
        dateExpLabel.text = loan?.date_exp
        dateIssueLabel.text = loan?.date_issue
        if loan?.loan_history!.count == 0 {
            statusLabel.text = "На рассмотрении"
        } else {
            statusLabel.text = LoanStatuses.all[(loan?.loan_history![0].status)!]
        }
        
        fioLabel.text = loan?.client?.name
        fraudLabel.text = "\(loan?.client?.fraud_scoring! ?? "")"
        dateIssuePassport.text = loan?.client?.pass_issue
        dateExpPassport.text = loan?.client?.pass_exp
        birthdateLabel.text = loan?.client?.date_of_birth
        passNumLabel.text = loan?.client?.pass_num
        passCountryLabel.text = loan?.client?.pass_country
        
        tableView.reloadData()
    }
    @IBAction func tableChangeAction(_ sender: Any) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if typeTable.selectedSegmentIndex == 0 {
            return (loan?.loan_history?.count)!
        } else {
            return (loan?.loan_transactions?.count)!
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if typeTable.selectedSegmentIndex == 0 {
            let history = loan?.loan_history![indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
            cell.dateLabel.text = "Дата: \(history?.date ?? "")"
            cell.nameLabel.text = LoanStatuses.all[(loan?.loan_history![indexPath.row].status)!]            
            return cell
        } else {
            let transaction = loan?.loan_transactions![indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
            cell.statusLabel.text = (transaction?.is_inside)! ? "Отправлено денег" : "Приход денег"
            cell.dateLabel.text = "Дата: \(transaction?.date ?? "")"
            cell.sumLabel.text = "Сумма: \(String(format: "%.2f", transaction?.sum ?? 0))"
            return cell
        }
    }

}
