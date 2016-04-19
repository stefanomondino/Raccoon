//
//  ListView.swift
//  Raccoon
//
//  Created by Leongiovanni on 12/04/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Raccoon
import ReactiveCocoa

class ListView: UIView {

    @IBOutlet weak var lbl_title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func bindViewModel(viewModel: ViewModel?) {
        let vm = viewModel as! ListModel
        self.lbl_title.text = vm.title
        //self.lbl_description.text = vm.desc
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
