//
//  MovieCell.swift
//  MyMovieChart
//
//  Created by Wonmi Kang on 2018. 1. 17..
//  Copyright © 2018년 odong. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var opendate: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var thumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
