//
//  BaseRequest.swift
//  ImgFlipRandomGenerator
//
//  Created by Chang Choi on 11/17/16.
//  Copyright © 2016 solechang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BaseRequest: NSObject {

    let apiEndpointURL = "https://api.imgflip.com"
    
    var completionBlock: ((_ responseObject: JSON?, _ error: Error?) -> ())?
    
    func path() -> String {
        return ""
    }
    
    func params() -> [String: AnyObject]? {
        return nil
    }
    
    func method() -> HTTPMethod {
        return HTTPMethod.get
    }

    
    func runCompletionBlock(_ responseObject: JSON?, error: Error) {
        if (completionBlock != nil) {
            completionBlock!(responseObject, error)
        }
    }
    func headers() -> [String : String]? {
        let key = "x-access-token"
        return [key : ""]
    }
    

    func runRequest() {
        Alamofire.request(path(), method: method(), parameters: params(), encoding: JSONEncoding.default, headers: headers()).responseJSON(completionHandler: { response in
            
            print("\n------------------------------------------------------")
            print("------------------------------------------------------")
            print("REQUEST:")
            print(response.request)
            print("------------------------------------------------------")
            print("RESPONSE:")
            print(response.response)
            print("------------------------------------------------------")
            print("RESULT:")
            print(response.result)
            print("------------------------------------------------------")
            
            if let responseValue = response.result.value {
                print("JSON:\n\(responseValue)")
                print("------------------------------------------------------")
                print("------------------------------------------------------\n")
                
                if self.completionBlock != nil {
                    let json = JSON(responseValue)
                    
                    if (json["error"] != nil)
                    {
                        self.completionBlock!(json, NSError(domain: "fanstori", code: 1, userInfo: [NSLocalizedDescriptionKey : json["error"].stringValue]))
                    }
                    else
                    {
                        self.completionBlock!(json, response.result.error)
                    }
                }
            }
            else {
                
                if self.completionBlock != nil {
                    self.completionBlock!(nil, response.result.error)
                }
            }
            
        })
        
    }
    

    
}
