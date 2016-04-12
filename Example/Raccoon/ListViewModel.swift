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
    let searchString:MutableProperty<String?> = MutableProperty(nil)
    override init () {
        super.init()
        
        self.reloadAction = Action({[unowned self] (string) -> SignalProducer<[[AnyObject]?], NSError> in
            return RESTManager.sharedInstance
                .searchWithString(string as? String)
                .map({return [$0]})
            
        })
        self.searchString.value = "Raccoon"
        
        var lastDisposable:Disposable?
        self.searchString.producer.throttle(0.5, onScheduler:QueueScheduler.mainQueueScheduler).startWithNext {[unowned self] (string) in
            print(string)
            if (lastDisposable != nil) {lastDisposable!.dispose();}
            lastDisposable = self.reloadAction?.apply(string).start()
        }
        
        
        
        self.nextAction = Action ({ [unowned self] (value:AnyObject) in
            
            if value is NSIndexPath{
                let indexPath = value as! NSIndexPath
                let item = self.modelAtIndexPath(indexPath) as? Track
//                print(item)
                let segueParameters = SegueParameters(segueIdentifier:"detailSegue",viewModel:DetailViewModel(trackDetail:item!))
                return SignalProducer.init(value:segueParameters)
            }
            return SignalProducer.init(value:nil)
        })
        
    }
    override func listIdentifiers() -> [String]! {
        return ["ListCollectionViewCell"]
    }
    override func listIdentifierAtIndexPath(indexPath: NSIndexPath) -> String! {
        return self.viewModelAtIndexPath(indexPath).listIdentifier()
    }
    override func listViewModelFromModel(model: AnyObject!) -> ViewModel! {
        return ListCellViewModel(model: model as! Track)
    }
}
