//
//  UIStackViewViewModel.swift
//  Pods
//
//  Created by Stefano Mondino on 15/04/16.
//
//
import Foundation
import UIKit


@available(iOS 9.0, *)
public extension UIStackView {
    
     public func setViewModel(viewModel:ViewModel?) {
        if (viewModel != nil) {
            viewModel!.sectionedDataSource.producer.startWithNext {[unowned self] (model:[[Any]?]) in
                let array = self.arrangedSubviews
                for view in array {
                    self.removeArrangedSubview(view)
                }
                
                model.first!?.forEach({[unowned self] (model) in
                    
                    let vm = viewModel!.listViewModelFromModel(model)!
                    let view:UIView = NSBundle.mainBundle().loadNibNamed(vm.listIdentifier(), owner: nil, options: nil).first as! UIView
                    view.bindViewModel(vm)
                    self.addArrangedSubview(view)
                    
                    
                    })
            }
            
        }
    }
}
