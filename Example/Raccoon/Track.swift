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
    
    class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return [
            "id":"id",
            "trackName":"trackName",
            "collectionName":"collectionName",
            "artwork":"artworkUrl100"
        ]
    }
}