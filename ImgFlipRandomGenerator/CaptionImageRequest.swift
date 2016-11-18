//
//  CaptionImageRequest.swift
//  ImgFlipRandomGenerator
//
//  Created by Chang Choi on 11/18/16.
//  Copyright © 2016 solechang. All rights reserved.
//

import UIKit
import Alamofire

class CaptionImageRequest: BaseRequest {

    var template_id: String
    var username: String
    var password: String
    var text0 :String
    var text1:String
    
    init( template_id: String, username: String, password: String, text0: String, text1:String ) {
        self.template_id = template_id
        self.username = username
        self.password = password
        self.text0 = text0
        self.text1 = text1
    }

    override func path() -> String {
        
        let url :String = "\(apiEndpointURL)/caption_image?template_id=\(self.template_id)&username=\(self.username)&password=\(self.password)&text0=\(self.text0)&text1=\(self.text1)"
        
        let escapedString = url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
               
        return escapedString!
    }
    
    override func method() -> HTTPMethod {
        return HTTPMethod.post
    }

    
}
