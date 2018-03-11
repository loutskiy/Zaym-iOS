//
//  SupportAnswer.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 11.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class SupportAnswer:Mappable {
    var id: Int?
    var support_ticket_id: Int?
    var user_id: Int?
    var user: User?
    var text: String?
    var date_issue: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- (map["id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        support_ticket_id <- (map["support_ticket_id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        user_id <- (map["user_id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        user <- map["user"]
        text <- map["text"]
        date_issue <- map["date_issue"]
    }
    
    func add () {
        Alamofire.request(ApiUrl.addAnswerToTicketId(support_ticket_id!), method: .post, parameters: Mapper().toJSON(self)).validate(statusCode: 200..<300).responseObject { (response: DataResponse<SupportAnswer>) in
            switch response.result {
            case .success:
                print("Validation Successful")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func delete () {
        Alamofire.request(ApiUrl.deleteAnswerById(id!, ticketId: support_ticket_id!), method: .delete, parameters: Mapper().toJSON(self)).validate(statusCode: 200..<300).response { (response) in

        }
    }
}
