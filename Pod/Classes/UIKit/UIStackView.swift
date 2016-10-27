//
//  UIStackViewViewModel.swift
//  Pods
//
//  Created by Stefano Mondino on 15/04/16.
//
//
import Foundation
import UIKit
import Result

@available(iOS 9.0, *)
extension UIStackView {
    
     open func setViewModel(_ viewModel:ViewModel?) {
        if (viewModel != nil) {
            viewModel!.sectionedDataSource.producer.startWithResult {[weak self] (result) in
                let array = self?.arrangedSubviews ?? []
                for view in array {
                    self?.removeArrangedSubview(view)
                }
                let model = result.value
                model?.first!?.forEach({[weak self] (model) in
                    
                    let vm = viewModel!.listViewModelFromModel(model)!
                    let view:UIView = Bundle.main.loadNibNamed(vm.listIdentifier(), owner: nil, options: nil)!.first as! UIView
                    view.bindViewModel(vm)
                    self?.addArrangedSubview(view)
                    
                    
                    })
            }
            
        }
    }
}
