    //
//  ClientSupportVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 11.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import Alamofire
    
class ClientSupportVC: UITableViewController {
    
    var supportTickets = [SupportTicket]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    @IBAction func refreshAction(_ sender: Any) {
        loadData()
    }
    
    func loadData() {
        Alamofire.request(ApiUrl.getSupportTicketsByClientId(UserCache.userId())).validate(statusCode: 200..<300).responseArray { (response: DataResponse<[SupportTicket]>) in
            switch response.result {
            case .success:
                self.supportTickets = response.result.value!
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
        return supportTickets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ticket = supportTickets[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientSupportCell", for: indexPath) as! ClientSupportCell

        cell.supportNameLabel.text = ticket.support_name
        cell.textUserLabel.text = ticket.text
        cell.countLabel.text = "Ответы: \(ticket.count_answers ?? 0)"
        cell.dateLabel.text = ticket.date_issue
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ticket = supportTickets[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SupportTicketAnswersVC") as! SupportTicketAnswersVC
        vc.ticket = ticket
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ticket = supportTickets[indexPath.row]
            ticket.delete()
            supportTickets.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

}
