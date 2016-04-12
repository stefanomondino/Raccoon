//
//  PreviewCellViewModel.swift
//  Raccoon
//
//  Created by Leongiovanni on 05/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Raccoon
import ReactiveCocoa
import Result
class PreviewCellViewModel: ViewModel {
    var url:NSURL!
    var action:Action<AnyObject?,SegueParameters!,NoError>!
    convenience init(url:NSURL, action:Action<AnyObject?,SegueParameters!,NoError>?) {
        self.init()
        self.action = action
        self.url = url
    }
    func buttonAction() {
        action.apply(url).start()
    }
    override func listIdentifier() -> String! {
        return "PreviewCollectionViewCell"
    }
}
