//
//  MovieDetailViewController.swift
//  TestProject
//
//  Created by ugur on 12.10.2019.
//  Copyright © 2019 ugur. All rights reserved.
//

import UIKit

import Firebase

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var lblAutor: UILabel!
    
    @IBOutlet weak var lblYear: UILabel!
    
    var movieTitle : String!
    var movieyear : String!
    var movieType :String!
    var moviePath :String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let helper = Helper()
        lblTitle.text = movieTitle
        lblAutor.text = movieType
        lblYear.text = movieyear
        helper.loadImg(path: moviePath,imageView: movieImg!)
        
        Analytics.logEvent(movieTitle, parameters: nil)
        Analytics.logEvent(movieType, parameters: nil)
         Analytics.logEvent(movieyear, parameters: nil)
        // Do any additional setup after loading the view.
    }
    
    
    

}
