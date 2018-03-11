//
//  Support.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 11.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class Support:Mappable {
    var id: Int?
    var name: String?
    var count_tickets: Int?
    var description: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- (map["id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        count_tickets <- map["count_tickets"]
        name <- map["name"]
        description <- map["description"]
    }
    
    func add () {
        Alamofire.request(ApiUrl.addSupport, method: .post, parameters: Mapper().toJSON(self)).validate(statusCode: 200..<300).responseObject { (response: DataResponse<LoanTransaction>) in
            switch response.result {
            case .success:
                ViewManager.topViewController().navigationController?.popViewController(animated: true)
                print("Validation Successful")
            case .failure(let error):
                print(error)
            }
        }
    }
}
