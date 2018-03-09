//
//  Loan.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class Loan:Mappable {
    var client_id: Int?
    var sum: Float?
    var sum_to_return: Float?
    var date_issue: String?
    var date_exp: String?
    var id: Int?
    var loan_history: [LoanHistory]?
    var loan_transactions: [LoanTransaction]?
    var client: Client?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        client_id <- (map["client_id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        sum <- (map["sum"], TransformOf<Float, String>(fromJSON: { Float($0!) }, toJSON: { $0.map { String($0) } }))
        sum_to_return <- (map["sum_to_return"], TransformOf<Float, String>(fromJSON: { Float($0!) }, toJSON: { $0.map { String($0) } }))
        date_issue <- map["date_issue"]
        date_exp <- map["date_exp"]
        id <- (map["id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        loan_history <- map["loan_history"]
        loan_transactions <- map["loan_transactions"]
        client <- map["client"]
    }
    
    func create () {
        Alamofire.request(ApiUrl.createLoan, method: .post, parameters: Mapper().toJSON(self)).validate(statusCode: 200..<300).responseObject { (response: DataResponse<Loan>) in
            switch response.result {
            case .success:
                ViewManager.topViewController().dismiss(animated: true, completion: nil)
                print("Validation Successful")
            case .failure(let error):
                print(error)
            }
        }
    }
}
