//
//  UserProfileVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 11.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import Alamofire

class UserProfileVC: UITableViewController {

    @IBOutlet weak var fioLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData () {
        Alamofire.request(ApiUrl.getUserById(UserCache.userId())).validate(statusCode: 200..<300).responseObject { (response: DataResponse<User>) in
            switch response.result {
            case .success:
                self.user = response.result.value
                self.fioLabel.text = self.user?.name
                self.loginLabel.text = self.user?.login
                switch self.user?.role {
                case 1?:
                    self.roleLabel.text = "Администратор"
                case 2?:
                    self.roleLabel.text = "Модератор"
                case 3?:
                    self.roleLabel.text = "Коллектор"
                default:
                    self.roleLabel.text = "Не определена"
                }

            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func exitAction(_ sender: Any) {
        UserCache.changeLoginState(false)
        dismiss(animated: true, completion: nil)
    }
}
