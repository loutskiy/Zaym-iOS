//
//  LoanTransaction.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class LoanTransaction:Mappable {
    var id: Int?
    var loan_id: Int?
    var is_inside: Bool?
    var nonce: String?
    var sum: Float?
    var date: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if map.mappingType == .toJSON {
            print("to json")
        }
 
        id <- (map["id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        loan_id <- (map["loan_id"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        is_inside <- (map["is_inside"], TransformOf<Bool, String>(fromJSON: { Bool(truncating: Int($0!)! as NSNumber) }, toJSON: { $0.map { String($0) } }))
        nonce <- map["nonce"]
        sum <- (map["sum"], TransformOf<Float, String>(fromJSON: { Float($0!) }, toJSON: { $0.map { String($0) } }))
        date <- map["date"]
    }
    
    func add () {
        Alamofire.request(ApiUrl.addClientTransaction(clientId: UserCache.userId(), loanId: loan_id!), method: .post, parameters: Mapper().toJSON(self)).validate(statusCode: 200..<300).responseObject { (response: DataResponse<LoanTransaction>) in
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
