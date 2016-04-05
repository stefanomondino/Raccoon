//
//  DetailCollectionViewCell.swift
//  Raccoon
//
//  Created by Leongiovanni on 04/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Raccoon
import ReactiveCocoa

class DetailCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setViewModel(viewModel: ViewModel?) {
        let vm = viewModel as! DetailCellViewModel
        self.lbl_title.text = vm.title
        self.lbl_description.text = vm.desc
    }
}
