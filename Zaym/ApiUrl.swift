//
//  ApiUrl.swift
//  Zaym
//
//  Created by Mikhail Lutskiy on 09.03.2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import Foundation

struct ApiUrl {
    private struct Domains {
        static let BetaUrl = "https://4zaym.bigbadbird.ru"
        static let ReleaseUrl = ""
    }
    
    private struct Routes {
        static let Api = "/api/"
    }
    
    private static let Domain = Domains.BetaUrl
    private static let Route = Routes.Api
    private static let BaseURL = Domain + Route
    
    static var user: String {
        return BaseURL + "user"
    }
    
    static var client: String {
        return BaseURL + "client"
    }
    
    static var loan: String {
        return BaseURL + "loan"
    }
    
    static var register: String {
        return client + "/reg"
    }
    
    static var authUser: String {
        return user + "/auth"
    }
    
    static var authClient: String {
        return client + "/auth"
    }
    
    static var createLoan: String {
        return loan + "/create"
    }

    static func getLoansByClientId (_ id: Int) -> String {
        return client + "/\(id)/loans"
    }
    
    static func addClientTransaction ( clientId: Int, loanId: Int) -> String {
        return client + "/\(clientId)/loans/\(loanId)/addPayment"
    }
    
    static func getClientById (_ id: Int) -> String {
        return client + "/\(id)"
    }
}
