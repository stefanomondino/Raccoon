//
//  ListViewModel.swift
//  Raccoon
//
//  Created by Stefano Mondino on 31/03/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//


import Raccoon
import ReactiveCocoa
import Result

class ListViewModel: ViewModel {
    var scheduler:Disposable?
    
    override init () {
        super.init()
        
        self.reloadAction = Action.init({ (_) -> SignalProducer<[[AnyObject]?], NSError> in
            return SignalProducer(value: [["1","2","3","4"]])
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
        return ListCellViewModel(model: model as! String)
    }
}
