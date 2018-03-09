//
//  ClientRegVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import SwiftPhoneNumberFormatter

class ClientRegVC: UITableViewController {
    @IBOutlet weak var fioField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    @IBOutlet weak var passNumField: PhoneFormattedTextField!
    @IBOutlet weak var passCountryField: UITextField!
    @IBOutlet weak var passDateIssuePicker: UIDatePicker!
    @IBOutlet weak var passDateExpPicker: UIDatePicker!
    @IBOutlet weak var passAuthField: UITextField!
    @IBOutlet weak var placeOfBirthField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passNumField.config.defaultConfiguration = PhoneFormat(defaultPhoneFormat: "#### ######")
        dateOfBirthPicker.maximumDate = Date()
        passDateExpPicker.minimumDate = Date().addingTimeInterval(60*60*24)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func registerAction(_ sender: Any) {
        if Checker.checkFieldsForFill(fioField.text!, emailField.text!, passwordField.text!, passNumField.text!, passCountryField.text!, passAuthField.text!, placeOfBirthField.text!) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let client = Client()
            client.name = fioField.text
            client.email = emailField.text
            client.password = passwordField.text
            client.date_of_birth = dateFormatter.string(from: dateOfBirthPicker.date)
            client.pass_num = passNumField.text
            client.pass_country = passCountryField.text
            client.pass_issue = dateFormatter.string(from: passDateIssuePicker.date)
            client.pass_exp = dateFormatter.string(from: passDateExpPicker.date)
            client.pass_authority = passAuthField.text
            client.place_of_birth = placeOfBirthField.text
            client.register()
        } else {
            showAlertMessage(text: "Заполните все поля", title: "Ошибка")
        }
    }
}
