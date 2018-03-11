//
//  UserSupportVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 11.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
class UserSupportVC: UITableViewController {
    
    var supports = [Support]()

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
    
    func loadData () {
        Alamofire.request(ApiUrl.support).validate(statusCode: 200..<300).responseArray { (response: DataResponse<[Support]>) in
            switch response.result {
            case .success:
                self.supports = response.result.value!
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
        return supports.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let support = supports[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupportCell", for: indexPath) as! SupportCell
        cell.nameLabel.text = support.name
        cell.descriptionLabel.text = support.description
        cell.countLabel.text = "Колличество обращений: \(support.count_tickets ?? 0)"

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let support = supports[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserSupportTicketsVC") as! UserSupportTicketsVC
        vc.support = support
        navigationController?.pushViewController(vc, animated: true)
    }
}
