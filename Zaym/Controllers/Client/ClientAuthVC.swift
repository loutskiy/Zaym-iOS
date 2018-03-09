//
//  ClientAuthVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit

class ClientAuthVC: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func authAction(_ sender: Any) {
        if Checker.checkFieldsForFill(emailField.text!, passwordField.text!) {
            let client = Client()
            client.email = emailField.text!
            client.password = passwordField.text!
            client.auth()
        } else {
            showAlertMessage(text: "Заполните все поля", title: "Ошибка")
        }
    }
}
