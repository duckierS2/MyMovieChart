//
//  MovieVO.swift
//  MyMovieChart
//
//  Created by Wonmi Kang on 2018. 1. 17..
//  Copyright © 2018년 odong. All rights reserved.
//

import Foundation
import UIKit

class HoppinRoot:Codable {
    var hoppin:Hoppin
}

class Hoppin:Codable {
    let totalCount:String
    var movies:Movies?
}

class Movies:Codable {
    var movie:[JsonMovie]?
}

class JsonMovie:Codable {
    var thumbnailImage:String
    var title:String
    var genreNames:String
    var linkUrl:String
    var ratingAverage:String
    
    required init?(coder aDecoder: NSCoder) {
        self.thumbnailImage = aDecoder.decodeObject(forKey: "thumbnailImage") as! String
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.genreNames = aDecoder.decodeObject(forKey: "genreNames") as! String
        self.linkUrl = aDecoder.decodeObject(forKey: "linkUrl") as! String
        self.ratingAverage = aDecoder.decodeObject(forKey: "ratingAverage") as! String
    }
}

class Movie {
    var thumbnail:String = ""
    var title:String = ""
    var genreNames:String = ""
    var linkUrl:String = ""
    var ratingAverage:Float = 0.0
    var thumbnailImage:UIImage? = nil
}
