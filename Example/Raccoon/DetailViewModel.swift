//
//  DetailViewModel.swift
//  Raccoon
//
//  Created by Leongiovanni on 04/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Raccoon
import ReactiveCocoa
import Result

class DetailViewModel: ViewModel {
    
    init(detail:Track) {
        super.init()
        print(detail)
        
        self.reloadAction = Action.init({ (_) -> SignalProducer<[[AnyObject]?], NSError> in
            return RESTManager.sharedInstance.searchWithString("Franz Ferdinand").map({return [$0]})
        })
        self.reloadAction?.apply(nil).start()
    }
    
    override func cellIdentifiers() -> [String]! {
        return ["ListCollectionViewCell"]
    }
    override func cellIdentifierAtIndexPath(indexPath: NSIndexPath) -> String! {
        return self.viewModelAtIndexPath(indexPath).cellIdentifier()
    }
    override func cellViewModelFromModel(model: AnyObject!) -> ViewModel! {
        return ListCellViewModel(model: model as! Track)
    }
}
