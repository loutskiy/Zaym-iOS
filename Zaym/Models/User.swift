//
//  User.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 10.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class User:Mappable {
    var id: Int?
    var role: Int?
    var login: String?
    var password: String?
    var name: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- (map["id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        name <- map["name"]
        role <- (map["role"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        password <- map["password"]
        login <- map["login"]
    }
    
    func auth () {
        print("clickkk")
        Alamofire.request(ApiUrl.authUser, method: .post, parameters: Mapper().toJSON(self)).validate(statusCode: 200..<300).responseObject { (response: DataResponse<User>) in
            switch response.result {
            case .success:
                UserCache.setUserId((response.result.value?.id)!)
                UserCache.changeLoginState(true)
                UserCache.changeClientState(false)
                print(UserCache.userId())
                print("Validation Successful")
                ViewManager.topViewController().dismiss(animated: true, completion: nil)
            case .failure(let error):
                if response.response?.statusCode == 400 {
                    ViewManager.topViewController().showAlertMessage(text: "Введенный логин или пароль неверен", title: "Ошибка")
                } else {
                    ViewManager.topViewController().showAlertMessage(text: "Проверьте интернет соединение", title: "Ошибка")
                }
                print(error)
            }
        }
    }
    func update () {
        Alamofire.request(ApiUrl.userById(UserCache.userId()), method: .post, parameters: Mapper().toJSON(self)).validate(statusCode: 200..<300).responseObject { (response: DataResponse<User>) in
            switch response.result {
            case .success:
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }
}
