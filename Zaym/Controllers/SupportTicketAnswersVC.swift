//
//  SupportTicketAnswersVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 11.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import Alamofire

class SupportTicketAnswersVC: UITableViewController {
    
    var ticket: SupportTicket?
    var answers = [SupportAnswer]()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshAction(_:)))
//        navigationItem.rightBarButtonItem = refreshButton
        
        if !UserCache.isClient() {
            let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction(_:)))
            navigationItem.rightBarButtonItem = addButton
            
            titleLabel.text = ticket?.client?.name
            textLabel.text = ticket?.text
            dateLabel.text = ticket?.date_issue
        } else {
            titleLabel.text = ticket?.support_name
            textLabel.text = ticket?.text
            dateLabel.text = ticket?.date_issue
        }
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    @objc func refreshAction(_ sender: Any) {
        loadData()
    }
    
    @objc func addAction(_ sender: Any) {
        //loadData()
        let alert = UIAlertController(title: "Добавить ответ", message: "Введите текст ответа", preferredStyle: .alert)
        let action = UIAlertAction(title: "Добавить", style: .default) { (action) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let answer = SupportAnswer()
            answer.support_ticket_id = self.ticket?.id
            answer.user_id = UserCache.userId()
            answer.date_issue = dateFormatter.string(from: Date())
            answer.text = alert.textFields?.first?.text
            answer.add()
            self.loadData()
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        alert.addTextField { (textField) in
            textField.placeholder = "Текст ответа"
        }
        present(alert, animated: true, completion: nil)
    }
    
    func loadData() {
        Alamofire.request(ApiUrl.getTicketById((ticket?.id)!)).validate(statusCode: 200..<300).responseArray { (response: DataResponse<[SupportAnswer]>) in
            switch response.result {
            case .success:
                self.answers = response.result.value!
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
        return answers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerCell

        cell.userNameLabel.text = answer.user?.name
        cell.answerLabel.text = answer.text
        cell.dateLabel.text = answer.date_issue
        // Configure the cell...

        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        if !UserCache.isClient() {
            return true
        }
        return false
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let answer = answers[indexPath.row]
            answer.delete()
            answers.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

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
