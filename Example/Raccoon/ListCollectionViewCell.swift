//
//  ListCollectionViewCell.swift
//  Raccoon
//
//  Created by Stefano Mondino on 31/03/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Raccoon
class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbl_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setViewModel(viewModel: ViewModel?) {
        let vm = viewModel as! ListCellViewModel
        self.lbl_title.text = vm.title
    }
}
