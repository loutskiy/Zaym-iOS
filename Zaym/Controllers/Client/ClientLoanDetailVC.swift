//
//  ClientLoanDetailVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit

class ClientLoanDetailVC: UITableViewController {

    @IBOutlet weak var typeTable: UISegmentedControl!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateExpLabel: UILabel!
    @IBOutlet weak var dateIssueLabel: UILabel!
    @IBOutlet weak var sumBackLabel: UILabel!
    @IBOutlet weak var sumToReturnLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    var loan: Loan?
    var sumReturned = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44
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
        
        let addPayment = UIBarButtonItem(title: "Погасить", style: .done, target: self, action: #selector(addPaymentAction))
        if (Double((loan?.sum_to_return)!) - sumReturned) > 0 {
            navigationItem.rightBarButtonItem = addPayment
        } else {
            navigationItem.rightBarButtonItem = nil
        }
        tableView.reloadData()
    }
    
    @objc func addPaymentAction () {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClientLoanPaymentVC") as! ClientLoanPaymentVC
        vc.sum = Double((loan?.sum_to_return)!) - sumReturned
        vc.loan = loan
        navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
