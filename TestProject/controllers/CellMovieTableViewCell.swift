//
//  CellMovieTableViewCell.swift
//  TestProject
//
//  Created by ugur on 12.10.2019.
//  Copyright © 2019 ugur. All rights reserved.
//

import UIKit

class CellMovieTableViewCell: UITableViewCell {

    
    @IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblYear: UILabel!
    
    @IBOutlet weak var lblAutor: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
