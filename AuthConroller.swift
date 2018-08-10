//
//  AuthConroller {.swift
//  COpenSSL
//
//  Created by Алексей Борисов on 11/07/2018.
//

import Foundation
import PerfectHTTP

class AuthController {
    
    let regiser: (HTTPRequest, HTTPResponse) -> () = { request, response in
        
        guard
            let str = request.postBodyString,
            let data = str.data(using: .utf8)
        else {
            response.completed(status: HTTPResponseStatus.custom(
                 code: 500,
                 message: "Wrong user data!"))
             return
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
            guard let registerRequest = RegisterRequest(json) else {
                try response.setBody(json: ["result": 0, "userMessage": "Ошибка регистрации!"])
                response.completed()
                return
            }
            print("Request - \(registerRequest)")
            
            try response.setBody(json: ["result": 1, "userMessage": "Регистрация прошла успешно!"])
            response.completed()
        } catch {
            response.completed(status: HTTPResponseStatus.custom(
                code: 500,
                message: "Parse data error - /(error)"))
        }
    }
}
