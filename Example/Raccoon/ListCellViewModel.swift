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
    convenience init(model:String!) {
        self.init()
        self.title = model
    }
    override func cellIdentifier() -> String! {
        return "ListCollectionViewCell"
    }
}
