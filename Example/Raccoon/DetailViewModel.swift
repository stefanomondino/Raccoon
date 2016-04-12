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
    
    var trackDetail:Track!
    var nextAction:Action<AnyObject?, SegueParameters!, NoError>!
    
    init(trackDetail:Track) {
        super.init()
        self.trackDetail = trackDetail
        
        self.reloadAction = Action.init({ (_) -> SignalProducer<[[AnyObject]?], NSError> in
            let headerViewModel = ListCellViewModel(model: self.trackDetail)
            let album = DetailCellViewModel(key: "Album: ", value: self.trackDetail.collectionName)
            let aPrice = DetailCellViewModel(key: "Album Price: ", value: String(self.trackDetail.albumPrice!) + " " + self.trackDetail.currency!)
            let track = DetailCellViewModel(key: "Track: ", value: self.trackDetail.trackName)
            let tPrice = DetailCellViewModel(key: "Track Price: ", value: String(self.trackDetail.trackPrice!) + " " + self.trackDetail.currency!)
            
            let tempString: String = self.trackDetail.trackViewUrl!
            //let newUrl = tempString.stringByReplacingOccurrencesOfString("https://", withString: "itms://")
            print(tempString)
            
            let preview = PreviewCellViewModel(url: NSURL(string: tempString)!, action: (self.nextAction))
            
            return SignalProducer(value: [[headerViewModel], [album], [aPrice], [track], [tPrice], [preview]])
        })
        
        
        
        self.nextAction = Action ({ [unowned self] (value:AnyObject?) in
            if (value is NSURL) {
                UIApplication.sharedApplication().openURL(value as! NSURL)
                return SignalProducer.init(value:nil)
            }

            return SignalProducer.init(value:nil)
        })
        self.reloadAction?.apply(nil).start()
    }
    
    override func listIdentifiers() -> [String]! {
        return ["ListCollectionViewCell", "DetailCollectionViewCell", "PreviewCollectionViewCell"]
    }
    override func listIdentifierAtIndexPath(indexPath: NSIndexPath) -> String! {
        return self.viewModelAtIndexPath(indexPath).listIdentifier()
    }
    override func listViewModelFromModel(model: AnyObject!) -> ViewModel! {
        return model as! ViewModel
    }
}
