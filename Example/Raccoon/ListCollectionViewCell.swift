//
//  ListCollectionViewCell.swift
//  Raccoon
//
//  Created by Stefano Mondino on 31/03/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Raccoon
import ReactiveCocoa

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_collectionTitle: UILabel!
    @IBOutlet weak var img_cover: UIImageView!
    
    private var imageDisposable:ReactiveCocoa.CompositeDisposable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func bindViewModel(viewModel: ViewModel?) {
        let vm = viewModel as! ListCellViewModel
        self.lbl_title.text = vm.title
        self.lbl_collectionTitle.text = vm.collectionTitle
        //if (self.superview != nil) {
        
//        self.imageDisposable?.dispose()
//            self.imageDisposable = ReactiveCocoa.CompositeDisposable.init()
//            
//            self.imageDisposable?.addDisposable(vm.imageSignalProducer
//                .map {$0 ?? UIImage.init(named: "img_pattern")?.resizableImageWithCapInsets(UIEdgeInsetsZero)}
//                .startWithNext { [unowned self ](image) -> () in
//                    self.img_cover.image = image
//                })
//        //}
    }
}
