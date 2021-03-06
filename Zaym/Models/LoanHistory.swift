//
//  LoanHistory.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class LoanHistory:Mappable {
    var id: Int?
    var loan_id: Int?
    var user_id: Int?
    var status: Int?
    var date: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        loan_id <- (map["loan_id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        user_id <- (map["user_id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        status <- (map["status"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        date <- map["date"]
        id <- (map["id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
    }
    
    func add () {
        Alamofire.request(ApiUrl.addStatusLoan(loanId:loan_id!), method: .post, parameters: Mapper().toJSON(self)).validate(statusCode: 200..<300).responseObject { (response: DataResponse<LoanHistory>) in
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
