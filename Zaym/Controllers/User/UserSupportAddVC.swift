//
//  UserSupportAddVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 11.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit

class UserSupportAddVC: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addAction(_ sender: Any) {
        if Checker.checkFieldsForFill(nameField.text!, descriptionField.text!) {
            let support = Support()
            support.name = nameField.text
            support.description = descriptionField.text
            support.count_tickets = 0
            support.add()
        } else {
            showAlertMessage(text: "Заполните все поля", title: "Ошибка")
        }
    }

}
