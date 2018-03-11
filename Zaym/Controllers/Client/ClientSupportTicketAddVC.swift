//
//  ClientSupportTicketAddVC.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 11.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit
import Alamofire

class ClientSupportTicketAddVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var supportPicker: UIPickerView!
    
    var supports = [Support]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        supportPicker.delegate = self
        supportPicker.dataSource = self
        loadData()
    }
    
    func loadData () {
        Alamofire.request(ApiUrl.support).validate(statusCode: 200..<300).responseArray { (response: DataResponse<[Support]>) in
            switch response.result {
            case .success:
                self.supports = response.result.value!
                self.supportPicker.reloadComponent(0)
            case .failure(let error):
                ViewManager.topViewController().showAlertMessage(text: "Проверьте интернет соединение", title: "Ошибка")
                print(error)
            }
        }
    }

    @IBAction func addAction(_ sender: Any) {
        if Checker.checkFieldsForFill(textField.text!) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let ticket = SupportTicket()
            ticket.text = textField.text
            ticket.client_id = UserCache.userId()
            ticket.date_issue = dateFormatter.string(from: Date())
            ticket.support_id = supports[supportPicker.selectedRow(inComponent: 0)].id
            ticket.add()
        } else {
            showAlertMessage(text: "Заполните все поля", title: "Ошибка")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return supports.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return supports[row].name
    }
}
