//
//  Helper.swift
//  TestProject
//
//  Created by ugur on 13.10.2019.
//  Copyright © 2019 ugur. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    func loadImg (path : String) -> UIImage {
        var ImageView = UIImage()
        
        if let url = URL(string: path){
            
            do {
                let data = try Data(contentsOf: url)
                ImageView = UIImage(data:data)!
                
                
            }catch{
                print(error)
            }
            
        }
        
        
        return ImageView
    }
}
