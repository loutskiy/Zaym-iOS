//
//  SupportTicket.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 11.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class SupportTicket:Mappable {
    var id: Int?
    var support_name: String?
    var count_answers: Int?
    var text: String?
    var client_id: Int?
    var date_issue: String?
    var support_id: Int?
    var client: Client?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- (map["id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        count_answers <- map["count_answers"]
        support_name <- map["support_name"]
        text <- map["text"]
        client_id <- (map["clinet_id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        date_issue <- map["date_issue"]
        support_id <- (map["support_id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        client <- map["client"]
    }
    
    func add () {
        Alamofire.request(ApiUrl.addSupportTicket(clientId: client_id!, supportId: support_id!), method: .post, parameters: Mapper().toJSON(self)).validate(statusCode: 200..<300).responseObject { (response: DataResponse<LoanTransaction>) in
            switch response.result {
            case .success:
                ViewManager.topViewController().navigationController?.popViewController(animated: true)
                print("Validation Successful")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func delete () {
        Alamofire.request(ApiUrl.deleteTicketById(id!), method: .delete, parameters: Mapper().toJSON(self)).validate(statusCode: 200..<300).response { (response) in
            
        }
    }
}
