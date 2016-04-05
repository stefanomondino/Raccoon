//
//  Track.swift
//  Raccoon
//
//  Created by Stefano Mondino on 02/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import Mantle
class Track:MTLModel, MTLJSONSerializing {
    
    var id:String?
    var trackName:String?
    var collectionName:String?
    var artwork:String?
    var previewUrl:String?
    var trackViewUrl:String?
    var trackPrice:NSNumber?
    var albumPrice:NSNumber?
    var currency:String?
    
    
    class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [
            "id":"id",
            "trackName":"trackName",
            "collectionName":"collectionName",
            "artwork":"artworkUrl100",
            "previewUrl":"previewUrl",
            "trackViewUrl":"trackViewUrl",
            "trackPrice":"trackPrice",
            "albumPrice":"collectionPrice",
            "currency":"currency"
        ]
    }
}