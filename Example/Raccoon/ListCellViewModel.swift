//
//  ListCellViewModel.swift
//  Pods
//
//  Created by Stefano Mondino on 31/03/16.
//
//

import Raccoon

class ListCellViewModel: ViewModel {
    var title:String!
    convenience init(model:Track!) {
        self.init()
        self.title = model.trackName
    }
    override func cellIdentifier() -> String! {
        return "ListCollectionViewCell"
    }
}
