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
    var nextAction:Action<AnyObject, SegueParameters!, NoError>!
    
    override init () {
        super.init()
        
        self.reloadAction = Action.init({ (_) -> SignalProducer<[[AnyObject]?], NSError> in
            return RESTManager.sharedInstance.searchWithString("Franz Ferdinand").map({return [$0]})
        })
        self.reloadAction?.apply(nil).start()
        
        self.nextAction = Action ({ [unowned self] (value:AnyObject) in
            
            if value is NSIndexPath{
                let indexPath = value as! NSIndexPath
                let item = self.modelAtIndexPath(indexPath) as? Track
//                print(item)
                let segueParameters = SegueParameters(segueIdentifier:"detailSegue",viewModel:DetailViewModel(detail:item!))
                return SignalProducer.init(value:segueParameters)
            }
            return SignalProducer.init(value:nil)
        })
        
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
