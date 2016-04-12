//
//  DetailCellViewModel.swift
//  Raccoon
//
//  Created by Leongiovanni on 04/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Raccoon
import ReactiveCocoa

class DetailCellViewModel: ViewModel {

    var title:String!
    var desc:String!
    
    //convenience init(model:Track!) {
    convenience init(key:String, value:String!) {
        self.init()
        //self.title = model.trackName
        self.title = key
        self.desc = value
    }
    
    override func listIdentifier() -> String! {
        return "DetailCollectionViewCell"
    }
}
