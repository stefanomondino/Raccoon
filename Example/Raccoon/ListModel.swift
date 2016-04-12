//
//  ListModel.swift
//  Raccoon
//
//  Created by Leongiovanni on 12/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Raccoon
import ReactiveCocoa

class ListModel: ViewModel {
    var title:String!
    //var desc:String!
    
    convenience init(key:String, value:String!) {
        self.init()
        //self.title = model.trackName
        self.title = key
        //self.desc = value
    }
    
    override func listIdentifier() -> String! {
        return "ListView"
    }
}
