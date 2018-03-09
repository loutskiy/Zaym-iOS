//
//  Client.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class Client:Mappable {
    var id: Int?
    var name: String?
    var email: String?
    var password: String?
    var date_of_birth: String?
    var pass_num: String?
    var pass_country: String?
    var pass_issue: String?
    var pass_exp: String?
    var pass_authority: String?
    var place_of_birth: String?
    var fraud_scoring: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- (map["id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        name <- map["name"]
        email <- map["email"]
        password <- map["password"]
        date_of_birth <- map["date_of_birth"]
        pass_num <- map["pass_num"]
        pass_country <- map["pass_country"]
        pass_issue <- map["pass_issue"]
        pass_exp <- map["pass_exp"]
        pass_authority <- map["pass_authority"]
        place_of_birth <- map["place_of_birth"]
        fraud_scoring <- map["fraud_scoring"]
    }
    
    func auth () {
        Alamofire.request(ApiUrl.authClient, method: .post, parameters: Mapper().toJSON(self)).validate(statusCode: 200..<300).responseObject { (response: DataResponse<Client>) in
            switch response.result {
            case .success:
                UserCache.setUserId((response.result.value?.id)!)
                UserCache.changeLoginState(true)
                UserCache.changeClientState(true)
                print(UserCache.userId())
                print("Validation Successful")
                ViewManager.topViewController().dismiss(animated: true, completion: nil)
            case .failure(let error):
                if response.response?.statusCode == 400 {
                    ViewManager.topViewController().showAlertMessage(text: "Введенный email или пароль неверен", title: "Ошибка")
                } else {
                    ViewManager.topViewController().showAlertMessage(text: "Проверьте интернет соединение", title: "Ошибка")
                }
                print(error)
            }
        }
    }
    
    func register () {
        Alamofire.request(ApiUrl.register, method: .post, parameters: Mapper().toJSON(self)).validate(statusCode: 200..<300).responseObject { (response: DataResponse<Client>) in
            switch response.result {
            case .success:
                UserCache.setUserId((response.result.value?.id)!)
                UserCache.changeLoginState(true)
                UserCache.changeClientState(true)
                print(UserCache.userId())
                print("Validation Successful")
                ViewManager.topViewController().dismiss(animated: true, completion: nil)
            case .failure(let error):
                if response.response?.statusCode == 500 {
                    ViewManager.topViewController().showAlertMessage(text: "Введенный email уже занят", title: "Ошибка")
                } else {
                    ViewManager.topViewController().showAlertMessage(text: "Проверьте интернет соединение", title: "Ошибка")
                }
                print(error)
            }
        }
    }
}
