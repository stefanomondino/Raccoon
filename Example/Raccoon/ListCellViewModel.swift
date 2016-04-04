//
//  ListCellViewModel.swift
//  Pods
//
//  Created by Stefano Mondino on 31/03/16.
//
//

import Raccoon
import ReactiveCocoa

class ListCellViewModel: ViewModel {
    
    var title:String!
    var collectionTitle:String!
    var artwork:String!
    
    var imageSignalProducer:SignalProducer<UIImage?,NSError>!
    
    convenience init(model:Track!) {
        self.init()
        self.title = model.trackName
        self.collectionTitle = model.collectionName
        self.artwork = model.artwork
        
        self.imageSignalProducer =  RESTManager.sharedInstance.getImageFromUrl(NSURL(string: self.artwork))
    }
    override func cellIdentifier() -> String! {
        return "ListCollectionViewCell"
    }
}
