//
//  PreviewCollectionViewCell.swift
//  Raccoon
//
//  Created by Leongiovanni on 05/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Raccoon
import ReactiveCocoa

class PreviewCollectionViewCell: UICollectionViewCell {
    
    var vm:PreviewCellViewModel!
    
    @IBOutlet weak var btn_preview: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        self.vm.buttonAction()
    }
    override func bindViewModel(viewModel: ViewModel?) {
        vm = viewModel as! PreviewCellViewModel
    }
}