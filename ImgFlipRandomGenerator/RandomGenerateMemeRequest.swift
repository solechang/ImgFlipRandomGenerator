//
//  RandomGenerateMemeRequest.swift
//  ImgFlipRandomGenerator
//
//  Created by Chang Choi on 11/17/16.
//  Copyright © 2016 solechang. All rights reserved.
//

import UIKit
import Alamofire

class RandomGenerateMemeRequest: BaseRequest {

    

    override func path() -> String {
        return "\(apiEndpointURL)/get_memes"
    }
    
    override func method() -> HTTPMethod {
        return HTTPMethod.get
    }
    
    
}
