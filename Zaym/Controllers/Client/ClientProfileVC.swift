//
//  ClientProfileVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 10.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class ClientProfileVC: UITableViewController {
    
    @IBOutlet weak var fioLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var passNumLabel: UILabel!
    @IBOutlet weak var passCountryLabel: UILabel!
    @IBOutlet weak var passDateIssueLabel: UILabel!
    @IBOutlet weak var passDateExpLabel: UILabel!
    @IBOutlet weak var passAuthLabel: UILabel!
    @IBOutlet weak var placeOfBirthLabel: UILabel!
    
    var client: Client?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(ApiUrl.getClientById(UserCache.userId())).validate(statusCode: 200..<300).responseObject { (response: DataResponse<Client>) in
            switch response.result {
            case .success:
                self.client = response.result.value
                self.fioLabel.text = self.client?.name
                self.emailLabel.text = self.client?.email
                self.dateOfBirthLabel.text = self.client?.date_of_birth
                self.passNumLabel.text = self.client?.pass_num
                self.passCountryLabel.text = self.client?.pass_country
                self.passDateIssueLabel.text = self.client?.pass_issue
                self.passDateExpLabel.text = self.client?.pass_exp
                self.passAuthLabel.text = self.client?.pass_authority
                self.placeOfBirthLabel.text = self.client?.place_of_birth
            case .failure(let error):
                print(error)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitAction(_ sender: Any) {
        UserCache.changeLoginState(false)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editAction(_ sender: Any) {
        let alert = UIAlertController(title: "Изменение пароля", message: "Введите ниже новый пароль для своего аккаунта", preferredStyle: .alert)
        let update = UIAlertAction(title: "Изменить", style: .default) { (action) in
            self.client?.password = alert.textFields?.first?.text
            self.client?.update()
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(update)
        alert.addAction(cancel)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Новый пароль"
            textField.isSecureTextEntry = true
        }
        present(alert, animated: true, completion: nil)
    }
}
