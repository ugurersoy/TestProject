//
//  Response.swift
//  TestProject
//
//  Created by ugur on 13.10.2019.
//  Copyright © 2019 ugur. All rights reserved.
//

import Foundation

struct Response :Decodable{
    let Response : String
    let Search : [Movie]
    let totalResults :String
    
}
