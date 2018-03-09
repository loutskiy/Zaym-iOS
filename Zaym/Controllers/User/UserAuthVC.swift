//
//  UserAuthVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit

class UserAuthVC: UIViewController {
    @IBOutlet weak var loginField: UITextField!
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
        if Checker.checkFieldsForFill(loginField.text!, passwordField.text!) {
            let user = User()
            user.login = loginField.text!
            user.password = passwordField.text!
            user.auth()
        } else {
            showAlertMessage(text: "Заполните все поля", title: "Ошибка")
        }
    }
}
