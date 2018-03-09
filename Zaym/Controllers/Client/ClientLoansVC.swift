//
//  ClientLoansVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class ClientLoansVC: UITableViewController {

    var loans = [Loan]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ZaymCell", bundle: nil), forCellReuseIdentifier: "ZaymCell")
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    @IBAction func refreshAction(_ sender: Any) {
        loadData()
    }
    
    func loadData () {
        Alamofire.request(ApiUrl.getLoansByClientId(UserCache.userId())).validate(statusCode: 200..<300).responseArray { (response: DataResponse<[Loan]>) in
            switch response.result {
            case .success:
                self.loans = response.result.value!
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
        // #warning Incomplete implementation, return the number of rows
        return loans.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let loan = loans[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZaymCell", for: indexPath) as! ZaymCell
        cell.sumLabel.text = "\(loan.sum ?? 0)₽"
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let loan = loans[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClientLoanDetailVC") as! ClientLoanDetailVC
        vc.loan = loan
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
