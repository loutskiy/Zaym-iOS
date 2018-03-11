//
//  UserSupportTicketsVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 11.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import Alamofire

class UserSupportTicketsVC: UITableViewController {
    
    var tickets = [SupportTicket]()
    var support: Support?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.navigationItem.title = support?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData() {
        Alamofire.request(ApiUrl.getTicketsForSupportId((support?.id)!)).validate(statusCode: 200..<300).responseArray { (response: DataResponse<[SupportTicket]>) in
            switch response.result {
            case .success:
                self.tickets = response.result.value!
                self.tableView.reloadData()
            case .failure(let error):
                ViewManager.topViewController().showAlertMessage(text: "Проверьте интернет соединение", title: "Ошибка")
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ticket = tickets[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientSupportCell", for: indexPath) as! ClientSupportCell
        cell.supportNameLabel.text = ticket.client?.name
        cell.textUserLabel.text = ticket.text
        cell.countLabel.text = "Ответы: \(ticket.count_answers ?? 0)"
        cell.dateLabel.text = ticket.date_issue
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ticket = tickets[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SupportTicketAnswersVC") as! SupportTicketAnswersVC
        vc.ticket = ticket
        navigationController?.pushViewController(vc, animated: true)
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
